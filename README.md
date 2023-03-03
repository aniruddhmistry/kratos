## Project Kratos
Project Kratos is a simple collection of small bash-scripts that runs iteratively to carry out various tools and recon process & store output in an organized way. This project was created initially for the automation of Recon for personal usage and was never meant to be public as there is nothing fancy about it but due to a request by the community, Project Kratos is now Public.

Please feel free to improve it in any way you can. There is no secret sauce involved and it's just a set of commands and existing tools written in bash-scripts for simple Recon Automation.

Project Kratos Supports an approach of Recon Methodology. Currently, this tool supports performing recon for:

1. Small Scope (single Domain/IP in scope): Performs a limited recon & is useful when only a few URLs are provided in the scope
2. Medium Scope (*.target.com in scope) : Performs recon to enumerate more assets and give you more options to attack on.

<img align="center" alt="img" src="https://github.com/aniruddhmistry/kratos/blob/main/Recon%20-%20Mind-map-Map%201.png" width="100%" height="auto" />

## Pre-Requisite

Make sure to have the "Docker Hub" installed on your machine.

### Docker Installation
If you are lazy like me and hate wasting time in setup don't worry, we have created the docker env. to use Kratos without any setup

we have integrated Kratos with Hacktools

 * ``docker pull aniruddhmistry/kratos:latest``

 * ``docker run -it aniruddhmistry/kratos``

or just simply type Kratos from any directory Simply interact with the terminal and hit the target

one-liner image publishing soon

### Sample Usage
```kratos example.com```

### Collaborators
1. Aniruddh Mistry  [Twitter](https://twitter.com/Aniruddh_Mistry) , [Linkedin](https://www.linkedin.com/in/aniruddh-mistry-b8540069/) ,  [Github](https://github.com/aniruddhmistry)
2. Ankit Tathe [Twitter](https://twitter.com/Beerboy_Ankit) , [Linkedin](https://www.linkedin.com/in/beerboy-ankit/), [Github](https://github.com/beerboy-ankit)

## Tools Used
* Naabu
* HTTPX
* smuggler
* gawk
* nuclei
* gau
* dirsearch
* nikto
* ffuf
* broken-link-checker

### Special Thanks to:

* Project Discovery (Httpx, Subfinder, chaos, nuclei)
* lc (gau)
* maurosoria (dirsearch)
* ffuf (ffuf)
* defparam (smuggler)
* stevenvachon (broken-link-checker)
* sullo (nikto)
* gvlx (gawk)

Please feel free to contribute.
