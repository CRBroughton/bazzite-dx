ARG BASE_IMAGE
FROM scratch AS ctx
COPY build_files /build_files

FROM scratch AS system_ctx
COPY system_files /files

FROM ${BASE_IMAGE}

# Layer 1: Heavy packages (cached unless build_files changes)
RUN --mount=type=tmpfs,dst=/tmp \
 --mount=type=bind,from=ctx,source=/,target=/run/context \
 mkdir -p /var/roothome && \
 /run/context/build_files/build.sh

# Layer 2: Copy system files directly (rebuilds when system_files changes)
RUN --mount=type=bind,from=system_ctx,source=/,target=/run/context \
 cp -avf /run/context/files/. /