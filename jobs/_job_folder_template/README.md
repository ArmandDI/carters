# Job Title Here

Add a brief description of the job.

Start date: [DD-MM-YYYY]
Estimated end date: [DD-MM-YYYY]

## Project Docs

 - Links to key documents in project's `docs` folder
 - Links to documents in other project folders
 - Include any links to documents or folders within the repo (e.g. in the [`client/docs`](../../docs) folder

## People Involved

 - List all staff involved in the job
 - Include roles and responsibilities
 - Client contacts could also be added if appropriate

## Folders

The default file structure should be adhered to as much as possible. Code will need to be written to output files to the correct locations.

**Notebooks** should be stored in the main job folder (top level) so that they can retrieve code from the [`input`](./_job_folder_template/input) folder and save to the [`output`](./_job_folder_template/output) folder.

Some of these folders are only here to make the code operate smoothly on a user's local machine. They may contain files that are not stored in GitHub due to their extension being listed in the repository's [`.gitignore`](../../master/.gitignore) file. If these files need to be stored in GitHub, they can be specifically included by adding a line to the job's [`.gitignore`](./_job_folder_template/.gitignore) file with an exclamation mark (force include) followed by an asterisk (wildcard) followed by the filename (e.g. `!*job_notes.docx`).

### [`archive`](./archive)

It's good practice to keep the repository as tidy as possible, so any files that are no longer needed should be placed here (e.g. EDA notebooks or early verisons of SQL scripts). This folder is not structured by language by default.

### [`docs`](./docs)

Documents relating to the job that are not otherwise stored in the `Client Documents` or `Jobs` folders on the shared drive (e.g. SoWs).
 - _Note:_ These can be included as links in the job's `README.md` file.

These documents can be reference documents, guides, notes, etc. They should be stored as `.txt` or `.md` files wherever possible.
If they are Microsoft Office files, they will need to be specifically listed in the job's [`.gitignore`](./_job_folder_template/.gitignore) file. 

### [`input`](./input)
Files used as inputs to any higher level code files, such as Jupyter Notebooks or R projects, which can be stored at the job folder level.

#### [`code`](./code)

Code files separated into folders by language (e.g. [`sql`](./_job_folder_template/code/sql/), [`python`](./_job_folder_template/code/python), [`r`](./_job_folder_template/code/sql)).

#### [`data`](./_job_folder_template/data)

Data files required as inputs by the code scripts or used as a reference. This should not be private or confidential data, and the main data source should be an external database or file on the shared drive.

Most data files (e.g. `.csv`, `.xlsx`, `.db`) will not be stored on GitHub unless specifically added to the job's [`.gitignore`](./_job_folder_template/.gitignore) file.

### [`output`](./_job_folder_template/output)

Output generated by the code scripts split into three sub-folders:
 - [`data`](./_job_folder_template/output/data): Data files such as `.csv` or `.pkl`.
 - [`figures`](./_job_folder_template/output/figures): Plots and other image files such as `.jpg`, `.png` or `bmp`.
 - [`models`](./_job_folder_template/output/models): Model files exported in a binary format such as `.pkl` or `.hdf5`.

Most of these files will not be stored on GitHub unless specifically added to the job's [`.gitignore`](./_job_folder_template/.gitignore) file. It is recommended that they be simultaneously uploaded to an external database or shared drive.
