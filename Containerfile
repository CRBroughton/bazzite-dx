ARG BASE_IMAGE

FROM scratch AS ctx

COPY system_files /files
COPY build_files /build_files

FROM ${BASE_IMAGE}

# Layer 1: Heavy packages (VSCode, etc.) - cached unless scripts change
RUN --mount=type=tmpfs,dst=/tmp \
 --mount=type=bind,from=ctx,source=/,target=/run/context \
 mkdir -p /var/roothome && \
 /run/context/build_files/build.sh

# Layer 2: System files (Flatpak lists, configs) - rebuilds when system_files change
RUN --mount=type=bind,from=ctx,source=/,target=/run/context \
 /run/context/build_files/build-configs.sh