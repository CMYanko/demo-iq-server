# Sonatype-Demo
Scripts meant to simplify the standup of IQ-Server and Nexus in Docker.

## Prerequisites
These scripts assume the following:
1. You have Docker installed locally
2. You have an active internet connection
3. You have been provided a license key by Sonatype

## Setup
1. Run demo-setup.sh
```bash
./demo-setup.sh
```
This will create folders and copy in a self-signed cert for NexusRM then run the docker-compse file.
```

```

2. Install license key in IQ server
    1. Navigate to http://localhost:8070
    2. Sign in (container defaults)
        * Username: admin
        * Password: admin123
    3. Select Install License > Locate License and Upload > Accept User Agreement   
3. Install license key in Nexus 
    1. Navigate to http://localhost:8081
    2. Sign in (container defaults)
       * Username: admin
       * Password: admin123
    3. Navigate to Administration 
    4. In the left hand Administration bar, navigate to licensing (near bottom of page)
    5. Select Install > Locate License and Upload > Accept User Agreement  
4. Restart Nexus to enable pro features (to include IQ integration). 
```bash
docker stop nexus3
docker start nexus3
```

5. Link Nexus to the IQ server container
    1. Login to Nexus at http://localhost:8081
    2. Navigate to Administration 
    3. In the left hand Administration bar, navigate to IQ Server > Server
    4. Configure IQ Server Lin
        1. Check "Whether to use IQ Server"
        2. For "The address of your IQ Server" enter **http://iq-server:8070**
        3. For "Authentication Method", select User Authentication
        4. Set username to **admin**
        5. Set password to **admin123**
        6. Verify Connection
        7. If you verify your connection successfully, select save

