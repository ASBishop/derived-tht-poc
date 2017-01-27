# Derived TripleO Heat Templates Proof of Concept
Demo part of https://review.openstack.org/#/c/423304

This is a quick python script to derive Heat Environment parameters
based on Ironic, other Heat Environment files, and user input. It's
just a POC to accompany a larger proposal to derive these values not
with a short Python script but with a Mistral workflow and then have
TripleO upload the generated THT file to the deployment plan. 

The script applies formulas determined from load testing HCI to avoid
contention between Nova and Ceph. HCI is just an example and there is
interest in deriving other Heat Env params. Details on the HCI choices
may be read at https://access.redhat.com/articles/2861641. 

The value of this is that the deployer does not need to do all of this
by hand. The deployer also does not need to know all of the formulas
or the hardware details. They just need to know their workload and may
then deploy an OpenStack/Ceph tuned to get the most of their workload.

Read the comments in tripleo_perf_profile.py for more details. 

## AsciiCast Demo
[![asciicast](https://asciinema.org/a/100907.png)](https://asciinema.org/a/100907)
