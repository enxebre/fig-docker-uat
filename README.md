User Acceptance Tests environment isolated with [Docker](https://www.docker.com/) containers orchestrated by [Fig](http://www.fig.sh/)
==================================================================================================================

### Requirements

For running this repo you need to set up an environment with the next tools:

* [docker](https://docs.docker.com/installation/)
* [fig](http://www.fig.sh/install.html)
* [composer](https://getcomposer.org/doc/00-intro.md#installation-nix)
* [git](http://git-scm.com/book/en/Getting-Started-Installing-Git)

### Installing

```bash
# Clone the repo
git clone https://github.com/enxebre/fig-docker-uat.git
```

```bash
# Retrieve the submodules (behat and puppuetforge modules)
git submodule update --init --recursive
```

```bash
# Install behat dependencies with composer
cd behat
composer install
```

### Usage

Just run:
```bash
# Running services
fig up
```

### Explanation

* This repo aims to show how to fit together a traditional VM, puppet, docker, fig and a behavior-driven development framework ([E.g. Behat](http://docs.behat.org/en/v2.5/)) for **creating an ephemeral UAT environment.**

* The repo contains two docker files, one for building a selenium image and the otherone for building an image with php so we can run Behat.

* We use the power of the [dockerfiles](http://docs.docker.com/reference/builder/) for reusing our "uat_environment" puppet module (a wrapper over [selenium module](https://forge.puppetlabs.com/jhoblitt/selenium) and its dependencies) and create a [docker image](https://registry.hub.docker.com/u/enxebre/selenium-grid-firefox/) with an instance of selenium running.

* By default it runs a selenium grid with one node containing 5 instaces of firefox listening and vnc server listening on port 5900. This can be easily modified by suiting the "uat_environment" puppet module so you can run selenium standalone or whatever fits better to you.

* The behat service check if the selenium container is ready by using the script inspired by [docker-wait](https://github.com/aanand/docker-wait) and just run [behat](https://github.com/enxebre/MinkExtension-example) which is passed as a volume to the container.

* We use fig for managing our basic UAT environment.
You can add as many selenium services as you need to your fig.yml and run different behavior-tests projects simultaneously becouse as we are [linking containers](http://docs.docker.com/userguide/dockerlinks/) we **don´t have to worry about port collision troubles.**
```yml
selenium:
 build: dockerfiles/selenium-image
behat:
 build: dockerfiles/behat-image
 volumes:
  - behat/:/behat/
 links:
  - selenium:selenium
```

* You can now run **"fig up"** or any other fig command for orchestrating your services from Jenkins or any other **CI tool.**
