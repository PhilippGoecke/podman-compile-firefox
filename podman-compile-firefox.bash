podman build --no-cache --rm --file Containerfile --tag firefox:demo .
podman run --interactive --tty firefox:demo
