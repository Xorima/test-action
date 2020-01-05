FROM ubuntu

LABEL "com.github.actions.name"="Chef Delivery"
LABEL "com.github.actions.description"="Runs the Chef Delivery on your cookbook"
LABEL "com.github.actions.icon"="filter"
LABEL "com.github.actions.color"="red"

COPY . .

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
