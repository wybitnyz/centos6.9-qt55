FROM centos:6.9

ENV QMAKE=qmake
ENV PATH="${PATH}:/opt/qt/5.5/gcc_64/bin/"
ADD qt-installer-noninteractive.qs .
ADD entrypoint.sh .

RUN yum install -y yum-utils && yum groupinstall -y "Development Tools" && yum install -y git wget curl libstdc++-devel make mesa-libGL-devel \
  && wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo \
  && yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ \
  && curl -sSL https://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run -o qt.run \
  && chmod +x qt.run \
  && sync \
  && ./qt.run --platform minimal --script qt-installer-noninteractive.qs -v \
  && source /opt/rh/devtoolset-2/enable \
  && alias git2http="sed -i -e 's : / ' -e 's git@ http:// '  .gitmodules" \
  && rm -rf \
    qt.run \
    /var/lib/apt/lists/* \
    /opt/qt/update.rcc \
    /opt/qt/components.xml \
    /opt/qt/InstallationLog.txt \
    /opt/qt/MaintenanceTool* \
    /opt/qt/Tools \
    /opt/qt/Docs \
    /opt/qt/network.xml \
    /opt/qt/Examples
ENTRYPOINT [ "entrypoint.sh" ]
