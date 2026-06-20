#!/usr/bin/env Rscript

read_and_summarize <- function(filepath, extension) {
    data <- switch(extension,
        "csv" = read.csv(filepath),
        "vcf" = readLines(filepath),
        "fasta" = readLines(filepath),
        stop("Unsupported file extension. Use csv, vcf, or fasta.")
    )

    summary_result <- switch(extension,
        "csv" = summarize_csv(data),
        "vcf" = summarize_vcf(data),
        "fasta" = summarize_fasta(data)
    )
}

summarize_csv <- function(data) {
    cat("CSV File Summary\n")
    cat("Rows:", nrow(data), "\n")
    cat("Columns:", ncol(data), "\n")
    cat("Column names:", paste(colnames(data), collapse = ", "), "\n")
}

summarize_fasta <- function(lines) {
    headers <- grep("^>", lines)
    n_sequences <- length(headers)

    seq_lines <- lines[!grepl("^>", lines)]
    total_length <- sum(nchar(seq_lines))
    # cat() is a function used to combine multiple objects and print them directly to the console or into a file
    cat("FASTA File Summary\n")
    cat("Number of sequences:", n_sequences, "\n")
    cat("Total sequence length:", total_length, "\n")
}

summarize_vcf <- function(lines) {
    data_lines <- lines[!grepl("^##", lines)]
    header <- data_lines[1]
    variants <- data_lines[-1]

    cat("VCF File Summary\n")
    cat("Number of variants:", length(variants), "\n")

    chrom_col <- sapply(strsplit(variants, "\t"), `[`, 1)
    cat("Chromosomes present:", paste(unique(chrom_col), collapse = ", "), "\n")
}


cat("Enter file path: ")
filepath <- readLines("stdin", n = 1)

cat("Enter file extension (csv/vcf/fasta): ")
extension <- tolower(readLines("stdin", n = 1))

if (!file.exists(filepath)) {
    stop("File not found: ", filepath)
}

tryCatch(
    {
        read_and_summarize(filepath, extension)
    },
    error = function(e) {
        cat("Something went wrong:", conditionMessage(e), "\n")
    }
)
