<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
<!-- [![LinkedIn][linkedin-shield]][linkedin-url] -->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/edwardbirdlab/HT-BALRROG">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">BALRROG</h3>

  <p align="center">
    High-Throughput BacteriaL Antimicrobial Resistance Of metaGenomes
    <br />
    ***** Still Under Development *****
    <br />
    <br />
    <!-- <a href="https://github.com/edwardbirdlab/HT-BALRROG"><strong>Explore the docs »</strong></a>
    <br /> 
    <br /> -->
    <!-- <a href="https://github.com/edwardbirdlab/HT-BALRROG">View Demo</a>
    · -->
    <a href="https://github.com/edwardbirdlab/HT-BALRROG/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/edwardbirdlab/HT-BALRROG/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

<!-- Workflow Overview -->
## Workflow Overview

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="images/balrog_workflow_light.png"> 
  <source media="(prefers-color-scheme: light)" srcset="images/balrog_workflow_light.png">
  <img alt="Nextflow Logo" src="images/balrog_workflow_light.png">
</picture>

*see below sections for in-depth subworkflow

<br />
<br />
<!--
<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



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


<!--
### Built With
-->
<!--
* [![Next][Next.js]][Next-url]
* [![React][React.js]][React-url]
* [![Vue][Vue.js]][Vue-url]
* [![Angular][Angular.io]][Angular-url]
* [![Svelte][Svelte.dev]][Svelte-url]
* [![Laravel][Laravel.com]][Laravel-url]
* [![Bootstrap][Bootstrap.com]][Bootstrap-url]
-->
<!--
* [![Nextflow][nextflow.io]][Nextflow-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/edwardbirdlab/HT-BALRROG.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/edwardbirdlab/HT-BALRROG/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING 
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com

Project Link: [https://github.com/edwardbirdlab/HT-BALRROG](https://github.com/edwardbirdlab/HT-BALRROG)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

```
                                               ...._
                                         ..-```      ``.._
                                    _--``             .-`````)
               .-````----.....___../`  /``                   ```)
            _.(-----._  -.,.   _._   <_)     ........      .-````)
           (__            (¬¬_> (_/\_)  `   .-``        `-._       -``)_
        .-(     .--`````    .-----------.       --.   -.   -._   .-`` )
       /`---   /`    /```` /.. /.vv.\...-.\         \    \    \     -```)
      /`--    /           |`)vV`    `Vv|  ).         \   |____/       ---)
     (__     /             \| /````````| /.\      \  __.-`  //// /`/````)
    (       /      /        v/  /``.....V\\        \/\ \ \ //// /    _.)  
   ( `-..  /      /__  |    .| /  /     \\\       /\     ///     _.-
  (_.-----/____  /`\___\     \ |  |     || |     /          _.-``
 (     _.r-\\  `//\    `\     \ \ \     // |     \      ,.-’`
(__.-\ \ \ \\  ////|      \_   \ ` \____/  /     \\   /
  `\.          /// |\       \   `\.  __   /      /\\  |
     `*-.________  | |       \     \  _  /   .^./  \\ |
                 ! / /        `-.   \___/ .-./ |    \\|
                 || /         ^._...,    (     )     \|
                 ||/          \.    |     \._./       v
                 (|)            `-..’     ./
                  V                 ``...`                                            
       ___             
|_|     |          __  
| |igh  |hroughput     
__            _                  __                __	         ___
|_|          /_\            |    |_|              |  |          | __
|_|acterial /   \ntimicrobia|__  | \estistance ann|__|tation of |__|enomes 
```

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
[license-url]: https://github.com/edwardbirdlab/HT-BALRROG/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[Nextflow-url]: https://nextflow.io
[nextflow.io]: https://github.com/nextflow-io/nextflow/workflows/Nextflow%20CI/badge.svg
