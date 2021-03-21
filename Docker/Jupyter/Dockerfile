FROM jupyter/datascience-notebook
USER root

RUN pip install jupyter_contrib_nbextensions autopep8 jupyterthemes && \
    pip install --upgrade jupyterthemes && \
    jupyter contrib nbextension install && \
    jupyter notebook --generate-config -y
RUN echo "c.NotebookApp.password='argon2:\$argon2id\$v=19\$m=10240,t=10,p=8\$90cor1WVRvT/JAu3Vw06Pg\$CQXrIT70DLVwvSVUEoYkqw'">>/home/jovyan/.jupyter/jupyter_notebook_config.py