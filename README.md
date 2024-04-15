<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->

<!-- PROJECT LOGO -->
<br />

<h3 align="center">BALROG-MON</h3>

  <p align="center">
    Bacterial Antimicrobial Resistance annOtation of Genomes - Metagenomic Oxford Nanopore
    <br />
    ***** Still Under Development *****
    <br />
    <br />
    <a href="https://github.com/edwardbirdlab/HT-BALRROG/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/edwardbirdlab/HT-BALRROG/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- Workflow Overview -->

<picture>
  <!-- Dark mode image -->
  <source media="(prefers-color-scheme: dark)" srcset="images/balrog_darkmode.png"> 
  <!-- Light mode image -->
  <source media="(prefers-color-scheme: light)" srcset="images/balrog_lightmode.png">
  <!-- Fallback image -->
  <img alt="Nextflow Logo" src="images/balrog_darkmode.png">
</picture>


## Workflow Overview

<picture>

  <source media="(prefers-color-scheme: dark)" srcset="images/balrog_workflow_light.png"> 
  <source media="(prefers-color-scheme: light)" srcset="images/balrog_workflow_light.png">
  <img alt="Nextflow Logo" src="images/balrog_workflow_light.png">
</picture>

*see below sections for in-depth subworkflows

<br />

<!--
<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-balrog">About BALROG</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#what-data-do-i-need">What Data do I Need?</a></li>
        <li><a href="#dependicies">Dependicies</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#creating-a-samplesheet">Creating Sample Sheets</a></li>
        <li><a href="#pipeline-configuriation">Pipeline Configuration</a></li>
      </ul>
    </li>
    <li>
      <a href="#running-balrog">Running Balrog</a>
      <ul>
        <li><a href="#quick-usage">Quick Usage</a></li>
      </ul>
    </li>
    <li>
      <a href="#core-steps">Core Steps</a>
      <ul>
        <li><a href="#data-preprocessing">Preprocessing</a></li>
        <li><a href="#host-removal">Host Removal</a></li>
        <li><a href="#assembly-mobile-element">Assembly and Plasmid Prediction</a></li>
        <li><a href="#amr-annotation">AMR Annotation</a></li>
      </ul>
    </li>
    <li>
      <a href="#optional-steps">Optional Steps</a>
      <ul>
        <li><a href="#community-analysis">Community Analysis</a></li>
        <li><a href="#pathogen-detection">Pathogen Detection</a></li>
        <li><a href="#additional-mobile-element">Additional Mobile Element Annotation</a></li>
        <li><a href="#additional-sequence-identification">AdditionalSequence Identification</a></li>
      </ul>
    </li>
  </ol>
</details>

<br />

<!-- ABOUT THE PROJECT -->


## About BALROG

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

BALROG is a nextflow pipeline built to utilize Q20+ Oxford Nanopore Long-reads to investigate antimicrobial resistance (AMR) and its mobility from metagenomic samples. While looking at AMR
is the main goal of BALROG, it also provides subworkflows for many related analysies, such as pathogen detection and metagenomic community analysis. 

<br />

## BALROG IS STILL IN DEVELOPMENT

Not all features are fully implemented, and while the pipeline MIGHT work in its current state, I would fully expect some troubleshooting to be in store. If you do deciede to test it out in its current state
please repot any and all bugs you find, or any suggestions for improvements!


<p align="right">(<a href="#readme-top">back to top</a>)</p>




<!-- GETTING STARTED -->
## Getting Started

Before you get too far along, familiarize youself with the section to make sure this is the pipeline for you, and that you can meet the requirements. (Don't worry, there isnt too much to do)

### What Data do I Need?

BALROG in its current form expects Q20+ Oxford Nanopore Long Read Metagenomic Sequecning. BALROG can run in Assembly-Free mode or assembles a metagenome using MetaFLYE, allowing for the analysis of low and high coverage metagenomes. BALROG in its standard configuration
 will require 100GB of RAM.
<br />
<br />
**If you would like to run BALROG with older, non-Q20+ Nanopore data, feel free to submit a feature request and I will add the option.**

### Dependicies

All Dependicies are mannaged via Docker Containers and hosted on DockerHub. One of the following container runtime software packages will be required.
<br />
1. Nextflow (>= 23.04.0.5857) - [Install Nextflow](https://www.nextflow.io/docs/latest/install.html)
2. Docker/Singularity/Apptainer - [Install Docker](https://docs.docker.com/engine/install/) - [Install Singularity](https://docs.sylabs.io/guides/3.0/user-guide/installation.html) - [Install Apptainer](https://apptainer.org/docs/admin/main/installation.html)

### Installation

1. Perfered Method - Download Release
   ```sh
   wget https://github.com/edwardbirdlab/BALROG-MON/releases/download/v0.0.0/BALROG-0.0.0.tar.gz
   tar -xzf BALROG-0.0.0.tar.gz
   ```
2. Clone Repo
   ```sh
   git clone https://github.com/edwardbirdlab/BALROG-MON
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Creating a Sample Sheet

BALROG takes a CSV (Comma-Seperted-Value) sheet as the input. Sample comlumn will be the prefix for all output files for that sample. 
<br />
Example Format:
```
sample,path,refernce_genome
Sample_Name_1,/absolute/path/to/sample1.fastq.gz,/absolute/path/to/reference_genome_1.fna
Sample_Name_2,/absolute/path/to/sample2.fastq.gz,/absolute/path/to/reference_genome_1.fna
```


<!-- ROADMAP 
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/edwardbirdlab/HT-BALRROG/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


-->

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Edward Bird -  - edwardbirdlab@gmail.com  |  edwardbird@ksu.edu

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/edwardbirdlab/HT-BALRROG.svg?style=for-the-badge
[contributors-url]: https://github.com/edwardbirdlab/HT-BALRROG/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/edwardbirdlab/HT-BALRROG.svg?style=for-the-badge
[forks-url]: https://github.com/edwardbirdlab/HT-BALRROG/network/members
[stars-shield]: https://img.shields.io/github/stars/edwardbirdlab/HT-BALRROG.svg?style=for-the-badge
[stars-url]: https://github.com/edwardbirdlab/HT-BALRROG/stargazers
[issues-shield]: https://img.shields.io/github/issues/edwardbirdlab/HT-BALRROG.svg?style=for-the-badge
[issues-url]: https://github.com/edwardbirdlab/HT-BALRROG/issues
[license-shield]: https://img.shields.io/github/license/edwardbirdlab/HT-BALRROG.svg?style=for-the-badge
[license-url]: https://github.com/edwardbirdlab/HT-BALRROG/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[Nextflow-url]: https://nextflow.io
[nextflow.io]: https://github.com/nextflow-io/nextflow/workflows/Nextflow%20CI/badge.svg
