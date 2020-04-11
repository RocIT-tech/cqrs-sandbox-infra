# Configure

## Understand the variables

* `REGISTRY_BASE`: Base registry (ex: my-registry/app)
* `SUB_REGISTRY`: Sub-path of the registry image (only one `/` allowed due to gitlab)
* `VERSION_TAG`: Tag of the created image
* `SSH_PRIVATE_KEY`: Content of the private key to use when cloning the repository (recommended to not set it here but using the export command. See below).
* `CLONE_BRANCH`: Branch / Tag to clone from
* `YARN_COMMAND`: Command executed by yarn. See `package.json` file under `scripts`
* `SERVER_ENV`: Name of the environment of the server. Should match the config directory structure.
* `SYMFONY_ENV`: Symfony environment. Used to dump the environment variables. (usually `dev`, `prod`)
* `SSH_GIT_REPOSITORY`: SSH git clone (ex: git@gitlab.kariba.fr:sandbox/symfony-sandbox.git)

## Create the `.env` file

Either create a `.env` file with the following variables:
```.dotenv
REGISTRY_BASE=ChangeMe
SUB_REGISTRY=
VERSION_TAG=latest

CLONE_BRANCH=develop
YARN_COMMAND=dev
SERVER_ENV=prod
SYMFONY_ENV=prod

SSH_GIT_REPOSITORY=ChangeMe
```

or copy the default one:
```bash
$ cp ./.env.dist
```

# Build & Push

Simply run the following:

```bash
$ export SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)
$ docker-compose build && docker-compose push
```

# Misc

## List all images that were built
*REQUIRES `jq`, `yq`*

```bash
# List all images built.
$ docker-compose config | yq . | jq --raw-output ".services | [. | to_entries[].value | select(.build != null) | .image] | unique | .[]"
```
