## Workflow

The script follows the workflow below:

```text
Start
   │
   ▼
Ask for file path
   │
   ▼
Does the file exist?
   │
 ┌─┴─────────┐
 │           │
No          Yes
 │           │
Ask again    ▼
        Ask for file extension
             │
             ▼
   Is it csv, vcf, or fasta?
             │
        ┌────┴────┐
        │         │
       No        Yes
        │         │
   Ask again      ▼
          Read the file
               │
               ▼
    Select the appropriate summarizer
               │
      ┌────────┼────────┐
      │        │        │
     CSV      VCF     FASTA
      │        │        │
      └────────┼────────┘
               ▼
      Display the summary
               │
               ▼
 Analyze another file? (yes/no)
               │
        ┌──────┴──────┐
        │             │
       Yes           No
        │             │
        └──────► Exit program
```

### Step-by-step process

1. The program prompts the user to enter the file path.
2. It checks whether the file exists.
   - If the file is not found, the user is asked to enter the path again.
3. The user specifies the file type (`csv`, `vcf`, or `fasta`).
   - If an unsupported extension is entered, the program requests a valid one.
4. The file is read using the appropriate function:
   - `read.csv()` for CSV files.
   - `readLines()` for VCF and FASTA files.
5. Based on the file type, the corresponding summarization function is called:
   - `summarize_csv()`
   - `summarize_vcf()`
   - `summarize_fasta()`
6. A summary of the file is printed to the console.
7. The user is asked whether they want to analyze another file.
   - Typing **yes** restarts the workflow.
   - Typing **no** exits the program.
