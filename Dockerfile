FROM node:16-alpine
LABEL maintainer="Postman Labs <help@postman.com>"


# Set environment variables
ENV LC_ALL="en_US.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" ALPINE_NODE_REPO="oznu/alpine-node"

# Bail out early if NODE_VERSION is not provided
RUN npm install -g newman
RUN npm install --global newman-reporter-htmlextra
# Set workdir to /etc/newman
# When running the image, mount the directory containing your collection to this location
#
# docker run -v <path to collections directory>:/etc/newman ...
#
# In case you mount your collections directory to a different location, you will need to give absolute paths to any
# collection, environment files you want to pass to newman, and if you want newman reports to be saved to your disk.
# Or you can change the workdir by using the -w or --workdir flag
WORKDIR /etc/newman

# Set newman as the default container command
# Now you can run the container via
#
# docker run -v /home/collections:/etc/newman -t postman/newman_alpine run YourCollection.json.postman_collection \
#                                                                        -e YourEnvironment.postman_environment \
#                                                                        -H newman_report.html
ENTRYPOINT ["newman"]