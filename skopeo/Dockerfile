FROM quay.io/skopeo/stable:latest

RUN touch /etc/subgid /etc/subuid \
 && chmod g=u /etc/subgid /etc/subuid /etc/passwd \
 && echo skopeo:10000:65536 > /etc/subuid \
 && echo skopeo:10000:65536 > /etc/subgid

# Use chroot since the default runc does not work when running rootless
#RUN echo "export BUILDAH_ISOLATION=chroot" >> /home/build/.bashrc


# Use VFS since fuse does not work
RUN mkdir -p /home/skopeo/.config/containers \
 && (echo '[storage]';echo 'driver = "vfs"';echo 'rootless_storage_path = "/home/skopeo/.local/share/containers/storage"') > /home/skopeo/.config/containers/storage.conf

USER skopeo
WORKDIR /home/skopeo

# Just keep the container running, allowing "oc rsh" access
CMD ["python3", "-m", "http.server"]
