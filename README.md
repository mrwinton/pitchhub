# Pitchhub
***

## Introduction

Pitchhub is a web application specifically designed to facilitate collaboration in the innovation ecosystem.

Key features of note:
  - built on ruby on rails
  - backed by MongoDB
  - made with love

If you're reading this that means that you're probably interested in writing code for the Pitchhub project. Cool! All documentation about the project including installation, technologies used and coding standards can be found here.

Getting Up & Running
====================
***

### Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Chef](https://downloads.chef.io/chef-dk/)

* Ruby (>= 2.0)

( We use [RVM](https://rvm.io) to manage our Ruby versions, it makes it super simple )

## Installing Berkshelf

Berkshelf is how we tell chef what application dependencies we want, to use berkshelf we need to place chef on our environment paths, here is how we do it on OSX:

In the `.bash_profile` add
```sh
PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH
```

If you're not on OSX or a *nix variant make sure to follow the [Chef](https://downloads.chef.io/chef-dk/) instructions for your OS.

## Installing Application Dependences

Pitchhub relies on a number of sweet technologies, mongodb and rvm to name a few. To standardise our development environment we use chef and vagrant to keep things simple.

Before we can boot our VM we need to install our dependencies (known as cookbooks in chef parlance). We can do this easily by opening up your favourite terminal and running:

    host $ git clone https://github.com/mrwinton/pitchhub.git
    host $ cd pitchhub/vagrant-box
    host $ sh install.sh
    
This may take a few minutes...

### What's in the box

* Development tools

* Ruby 2.1

* Bundler

* MongoDB

* Google's V8 javascript engine

### What's coming soon

* Redis or Memcached

* Delayed_Job or Sidekiq 

## How To Build The Virtual Machine

Building the virtual machine is also easy, while in the `pitchhub/vagrant-box` directory go:

Install vagrant plugins: [bindfs](https://github.com/gael-ian/vagrant-bindfs), [triggers](https://github.com/emyl/vagrant-triggers), [vbguest](https://github.com/dotless-de/vagrant-vbguest/):

    host $ vagrant plugin install vagrant-bindfs #only required for OSX
    host $ vagrant plugin install vagrant-triggers
    host $ vagrant plugin install vagrant-vbguest
    
    #boot our vagrant instance!
    host $ vagrant up

That's it. Note that on the first run this will definitely take a while as we are not only downloading and installing Ubuntu but also installing all the cookbook dependencies as well as ruby.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-48-generic x86_64)
    ...
    vagrant@pitchbox:~$

#### Troubleshooting

At times Vagrant may get a little flustered and exit with an error while configuring our dependencies, sometimes `vagrant provision` will push it in the right direction. If the same error occurs, please check google or ask us here.

Chef behaves more often than not but if Chef is running anything lower than Chef 12.2.X then things can get messy, make sure you don't have any Chef/Vagrant plugins overriding our Vagrantfile's chef config and you should be good as gold.

## Virtual Machine Management

When done just log out with `^D` or `exit` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: everything will go

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.


## Running

Nealy there! Install the gems with `bundle install` and you're ready to start tinkering now.

Our pitchbox VM has a few handy commands that make things a little easier:

    $ pcd # will cd into the pitchhub directory where our code lives

    $ pup # starts the rails server at localhost:3000/ - to exit hit `ctrl-c`

When you're running the server take your favourite web browser and navigate to [localhost:3000](http://localhost:3000/) and you should see the index page!

Contributing
====================
***

##Git Branching Model

Pitchhub uses a fairly simple branching model with Git that should be followed at all times.

* **master:** Source of production pulls. Merge from staging will be done during production pulls; only touch for hotfixes.

* **staging:** Source of dev pulls. Merge from dev done automatically with testing during dev pulls.

* **develop:** Stable development versions. Merge from feature branches and do atomic commits here.

You should create new feature branches whenever working on something new. Once it's stable, merge it back into develop, and then delete the branch locally (and remotely if it applies).

## Roadmap

### Todo's

 - Write Migrations and Migrations section
 
 - Write Tests and Testing Section

##Coding Standards

Please try to follow best practies:

 - [Ruby](https://github.com/bbatsov/ruby-style-guide)
 
 - [Rails](https://github.com/bbatsov/rails-style-guide)

License
====================
***

MIT


**Open Source Software, Hell Yeah!**

