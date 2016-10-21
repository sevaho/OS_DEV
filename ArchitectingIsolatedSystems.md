#Architecting isolated systems

##NOT COMPLETE

&nbsp;

##Userspace vs kernelspace

&nbsp;

http://rhelblog.redhat.com/2015/07/29/architecting-containers-part-1-user-space-vs-kernel-space/

&nbsp;

##Namespacing

&nbsp;

https://www.toptal.com/linux/separation-anxiety-isolating-your-system-with-linux-namespaces

Just as **chroot** allows processes to see any arbitrary directory as the root of the system (independent of the rest of the processes), Linux namespaces allow other aspects of the operating system to be independently modified as well. This includes the process tree, networking interfaces, mount points, inter-process communication resources and more.

&nbsp;

##Process namespacing

&nbsp;

```html

._____________.                      ._______________.                           
|             |                      |               |           
| User Space  |                      | Kernel Space  |    
|             |   --System call-->   |               |               
| - processes |                      | - RAM         |            
|             |                      | - disk        |            
|_____________|                      |_______________|      

```

&nbsp;

```Bash



```
