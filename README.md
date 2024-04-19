# [Client Name Here](https://clientwebsite.com)

Add a brief description of the client and the general work required.

## Documents

 - Add links here to client folders on shared drives (e.g. those in `I:/Client Documents`)
 - Include links to any other relevant folders, websites or documents
 - Any key documents stored in the [`docs`](./docs) folder can also be linked to here 

## Jobs

 - List all client's jobs here
 - Include [link to GitHub job's folder](./jobs) if exists
 - Include name of branch (and possibly link to final branch merge) if no job folder was created

## Folders

### [`code`](./code)

Client-specific code that is useful beyond a particular project, e.g. SQL scripts for wrangling client data or Python function scripts.

Code files are split by language (e.g. [`sql`](./_job_folder_template/code/sql/), [`python`](./_job_folder_template/code/python), or [`r`](./_job_folder_template/code/sql)). 

Job-specific code should _not_ be stored here, but rather in the relevant [job](./jobs) folder.

### [`docs`](./docs)

Documents relating to the job that are not otherwise stored in the `Client Documents` or `Jobs` folders on the shared drive (e.g. SoWs).

These can be reference documents, guides, notes, etc. They should be stored as .txt or .md files wherever possible. If they are Microsoft Office or PDF files, they will need to be specifically added to the client's [`.gitignore`](.gitignore) file or else they won't be stored on GitHub. This is done by adding a new line with an exclamation mark (force include) followed by an asterisk (wildcard) followed by the filename (e.g. `!*client_doc.docx`).

### [`jobs`](./jobs)

Individual job folders containing job-specific files. See [`jobs\README.md`](./jobs/README.md) for more info.
