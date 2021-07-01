FROM mundialis/grass-py3-pdal:stable-ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8

RUN apt-get update
RUN pip3 install sentinelsat pandas "pygdal>=2.2.3,<2.2.4"
RUN grass -c EPSG:32636 grassdata/proj36Loc

RUN g.extension extension=i.sentinel

CMD ["/bin/bash"]