# webMethods Microservices Runtime BPM Demo

Simple Demo Package for deploying a BPMS process inside a Microservices Runtime (MSR) Docker Container. Note: This  package is not intended for production environments - just for local demo cases. 

## Prerequisites

### Environment properties

Adjust the .env file (copy from .env-template if it does not exist) and add your credentials for Empower as well as your Docker Registry credentials

```
EMPOWER_USER=<your empower user for the creation of the base image and dcc>
EMPOWER_PASSWORD=<your empower password>
DOCKER_REGISTRY=<your registry url>
DOCKER_USERNAME=<your registry user (must be able to push images) >
DOCKER_PASSWORD=<your registry password >
DOCKER_PROJECT=<docker project for grouping artifacts>
SAG_CR_USER=<Get `Username` https://containers.softwareag.com/products -> Settings > Container registry credentials > `Username` >
SAG_CR_PWD=<create password with your empower account at https://containers.softwareag.com/products -> Settings > Container registry credentials > `Generate password` >
```

### Licenses

Add the following licenses to the directory `licenses` in the `run` dir:

- 'is-license.xml'
- 'um-license.xml'

### Configuration

By default the configuration for the MSR is taken from the following variable template located in `config`:

```
jdbc.pe.dbURL=jdbc:wm:postgresql://db:5432;databaseName=postgres
jdbc.pe.password=manage
jdbc.pe.userid=postgres
jdbc.pe.driverAlias=DataDirect Connect JDBC PostgreSQL Driver
jdbc.pe.maxConns=10
jdbcfunc.ISCoreAudit.connPoolAlias=pe
jdbcfunc.ISDashboardStats.connPoolAlias=pe
jdbcfunc.ISInternal.connPoolAlias=pe
jdbcfunc.Xref.connPoolAlias=pe
jdbcfunc.ProcessEngine.connPoolAlias=pe
jdbcfunc.DocumentHistory.connPoolAlias=pe
jdbc.pa.dbURL=jdbc:wm:postgresql://db:5432;databaseName=postgres
jdbc.pa.password=manage
jdbc.pa.userid=postgres
jdbc.pa.driverAlias=DataDirect Connect JDBC PostgreSQL Driver
jdbc.pa.maxConns=10
jdbcfunc.ProcessAudit.connPoolAlias=pa
jdbc.cus.dbURL=jdbc:wm:postgresql://db:5432;databaseName=postgres
jdbc.cus.password=manage
jdbc.cus.userid=postgres
jdbc.cus.driverAlias=DataDirect Connect JDBC PostgreSQL Driver
jdbcfunc.CentralUsers.connPoolAlias=cus
settings.watt.server.threadPool=750
settings.watt.server.serverlogFilesToKeep=1
settings.watt.server.stats.logFilesToKeep=1
settings.watt.net.localhost=processengine
statisticsdatacollector.monitorConfig.enabled=false
peproperty.watt.prt.externalcluster=true
peproperty.watt.prt.uploadMetadata=true
jms.DEFAULT_IS_JMS_CONNECTION.clientID=d01-pe
jms.DEFAULT_IS_JMS_CONNECTION.enabled=true
jms.PE_NONTRANSACTIONAL_ALIAS.clientID=d01-pe
jms.PE_NONTRANSACTIONAL_ALIAS.enabled=true
jndi.DEFAULT_IS_JNDI_PROVIDER.enabled=true
jndi.DEFAULT_IS_JNDI_PROVIDER.providerURL=nsp://um:9000
messaging.IS_UM_CONNECTION.CLIENTPREFIX=processengine
messaging.IS_UM_CONNECTION.enabled=true
messaging.IS_UM_CONNECTION.url=nsp://um:9000
monproperty.wm.monitor.myWebmethodsHost=mws
monproperty.wm.monitor.myWebmethodsPassword=manage
monproperty.wm.monitor.myWebmethodsPort=8585
peproperty.watt.prt.optimizeBrokerURL=nsp://um:9000
```

## Directory structure

### dcc

Build and configuration for creation of a Database Configurator Image that can be used to automatically create all tables required by a full-stack BPMS webMethods installation (e.g. MWS, ProcessEngine, ProcessAudit)

### msr

Base MSR + BPMS Build scripts using the Software AG Installer.

### msr-solution

Solution Image build scripts using the msr base image. This directory also contains the solution packages including the process files. 

In order to deploy process models from a container at startup, Process model and Frag files need to be present in the generated Process package. See the `Demo` package for an example (sub-directories: `config/model` and `config/wmprt`).

See also https://documentation.softwareag.com/webmethods/designer/sdf10-15/webhelp/sdf-webhelp/pdf/bpm-process-development-help.pdf Page 453 (Metadata Deployment and Process Activation). 

### mws

MWS image build scripts. 

### run

Docker Compose for starting up an entire environment with the following components:

- postgress database
- init db using the database configurator container as build by scripts in `dcc` directory
- microservice runtime solution container as build by scripts in `msr-solution` directory
- MyWebMethodsServer container as build by scripts in `mws` directory
- Universal Messaging server container 10.15 from the public SoftwareAG container registry https://containers.softwareag.com

To start the entire environment simply execute docker compose:

```docker-compose up```

Make sure that you have logged into the SoftwareAG Repository by executing:

. .env && docker login sagcr.azurecr.io --username=$SAG_CR_USER --password=$SAG_CR_PASSWORD
