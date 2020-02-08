Terraform project to connect Jenkins Slave Node to Master Node.

To use this project, make sure you have the jenkins Master node is already set up and necessary configurations are made.

Jenkins -> Global Security Configuration -> Agents -> Agent protocols -> Inbound TCP Agent Protocol/4 (TLS encryption).

Make sure you have the ephermal ports opened in your Jenkins Master Node security groups ( 1024 - 65535). And enter the port in the above link where Jenkins Master node will use it for communication from Master to Slave(for ex, 35179).

This is a simple project to add slave to master node.
