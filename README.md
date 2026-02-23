# RustDesk-Server-FreeBSD
[RustDesk](https://rustdesk.com/), a remote management program, differs from similar programs in that you can use your own [open source RustDesk Server](https://github.com/rustdesk/rustdesk-server) to connect clients and work without restrictions. [GitHub repository](https://github.com/rustdesk/rustdesk-server) offers ready-made builds for many operating systems, but there are no pre-built binaries or launch scripts for FreeBSD (and XigmaNAS).

You can build the binaries yourself from source, but keep in mind that binaries built on FreeBSD 15 do not work on earlier versions of FreeBSD (a newer version of the glibc library is required). Binaries built on FreeBSD 14.3 work on both 14.3 and 15.0.
All that's left to do is create rc.d scripts and install them. Use the files install.sh, hbbr.tmpl, hbbs.tmpl, and rustdesk.conf.tmpl for this.

## Simple installation of RustDesk Server on FreeBSD or XigmaNAS
1. Create a folder for the server and go to it.
2. According to your FreeBSD or XigmaNAS version, run\
    ```fetch https://github.com/Nivigor/RustDesk-Server-FreeBSD/releases/latest/download/RustDeskServer-FreeBSD-v14.3-x64.tgz``` \
   or run\
   ```fetch https://github.com/Nivigor/RustDesk-Server-FreeBSD/releases/latest/download/RustDeskServer-FreeBSD-v15.0-x64.tgz```
3. Run ```tar xzf RustDeskServer*.tgz```
4. Run ```./install.sh```
5. For XigmaNAS embedded: add install.sh to WebGUI: Advanced: Command Scripts as a PostInit command.

You can check the servers' operation with the commands ```service hbbr status``` and ```service hbbs status```. Copy the contents of the bin/id_ed25519.pub file. This key is required to configure RustDesk to use your server.

## Manual installation

Create a folder for the server and open it. Copy the files install.sh, hbbr.tmpl, hbbs.tmpl, and rustdesk.conf.tmpl here. Create the log and bin folders. Place the hbbs, hbbr, and rustdesk-utils binaries in the bin folder. You can take these from the release.

Now you can configure logging and log rotation. The hbbr and hbbs servers are started by the daemon utility, and logging is controlled by its options. These options can be changed by setting the hbbr_flags and hbbs_flags variables in rc.conf. The default values for these variables are "-o {work dir}/log/hbbr.log" and "-o {work dir}/log/hbbs.log". These variables should only contain [daemon(8)](https://man.freebsd.org/cgi/man.cgi?daemon) logging options.

Log rotation is performed by newsyslog. Rotation parameters are set in the /usr/local/etc/newsyslog.conf.d/rustdesk.conf file, which is derived from rustdesk.conf.tmpl. This file can be modified.

After configuration, run ```./install.sh```

***
 [About RustDesk](https://rustdesk.com/)
