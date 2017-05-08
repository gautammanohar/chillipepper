# chillipepper

* Install custom script to count number of lines in all files (*.log) in the /var/log directory     
* Create new users sharing a common public/private key-pair for SSH access.    

## Available states ##
* logcount { installs script for log lines count }    

## Included formulas ##
* users-formula { creates new users }

### logcount ###
To customize locations,names of directories, files and scripts, modify variables here [HERE](https://github.com/gautammanohar/chillipepper/blob/master/pillar/logcount/init.sls). Do not attempt to do this directly in the state files.

### users ###
To create new users add user details [HERE](https://github.com/gautammanohar/chillipepper/blob/master/pillar/users/init.sls). Do not attempt to do this directly in the state files.


## AWS Setup ##

* Provision a new Ubuntu server on your AWS account.     
* Ensure that while provisioning you add user-data as seen [HERE](https://github.com/gautammanohar/chillipepper/blob/master/cloud-init.txt). This file sets the hostname which is required for minions to communicate with master. It also adds the saltstack repository for the package manager.   
* Once server is up and running, ssh into the server and change to root.     
* Update and Upgrade         
    ```sh
    # apt-get update && apt-get upgrade -y
    ```    

* Install master and minion        
    ```sh
    # apt-get install salt-master salt-minion      
    ```

* After installation approve the key for the minion. Run the following command to get a list of keys and their status.
    ```sh
    # salt-key    
    ```

* From the list select the key that needs to accepted.   
    ```sh
    # salt-key -a <name_of_key>    
    ```

* Edit the file /etc/salt/master. Ensure that the section for file_roots has the following paths:     
    ```
    file_roots:     
      base:      
        - /srv/chillipepper      
        - /srv/formulas/users-formula    
    ```

* Edit the file /etc/salt/master. Ensure that the section for pillar_root has the following paths:     
    ```
    pillar_roots:        
      base:       
        - /srv/chillipepper/pillar   
    ```

* Clone the users-formula repo.
    ```sh
    # cd /srv          
    # mkdir formulas         
    # cd formulas/          
    # git clone https://github.com/saltstack-formulas/users-formula.git       
    ```

* Clone this repository.
    ```sh
    # cd /srv                  
    # git clone https://github.com/gautammanohar/chillipepper.git          
    ```

* You can run the state files for the desired outcome (log counting script as well as user creation).
    ```sh
    # salt '*' state.highstate     
    ```    

* If you need to only create users, then
    ```sh
    # salt '*' state.sls users
    ```    

* If you need to only install the log counting script
    ```sh
    # salt '*' state.sls logcount
    ```  
