# Deployment Container

This image provides deployment tools ready to be used in CI.

## Example

### 1. Create SSH key to connect to docker host

Create an SSH key pair on the target host and save the private key as a CI/CD file variable `SSH_PRIVATE_KEY_FILE`.

```console
root@my-instance:~# ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
```

### 2. Collect SSH hosts keys from docker host

SSH needs to know the host key of the machines it connects to.

#### SSH_KNOWN_HOST_FILE

Run `ssh-keyscan <target>` to collect all SSH host keys:

```console
ssh-keyscan <target>
```

Add them to a CI/CD file variable `SSH_KNOWN_HOSTS_FILE`.

The variable can be updated independently of any Git commit. Therefore, even older commits can be deployed again when the server has changed.

#### .ssh/known_hosts

Alternatively, you can add them as a file to the repository:

```console
mkdir .ssh
ssh-keyscan <target host> > .ssh/known_hosts
```

`setup-ssh` will use both sources if available.

### 3. Set up deployment configuration

```yaml
deploy production:
  image: ghcr.io/jgraichen/deploy:1

  # Optional: run deploy jobs only manual or add other rules
  # when to deploy automatically.
  when: manual

  variables:
    TARGET_HOST: root@<target host>
    DOCKER_HOST: ssh://${TARGET_HOST}

  before_script:
    - eval "$(ssh-agent -s)"
    - setup-ssh
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY

  script:
    # If needed, sync local configuration files to server
    - rsync --mkpath --recursive --verbose "config/" "${TARGET_HOST}/srv/compose/config/"

    # Deploy docker-compose to single host
    - docker-compose up --detach

    # Or a stack to swarm node or cluster
    - docker stack deploy --compose-file docker-compose.yml

  # Optional define a environment
  environment:
    name: production
    url: https://example.org

  # Ensure only one deployment job is run concurrently
  resource_group: production
```
