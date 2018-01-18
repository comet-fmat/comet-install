**1.- Open Git Bash.**

**2.- Paste the text below, substituting in your GitHub email address.**

    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   
   This creates a new ssh key, using the provided email as a label. 

	Generating public/private rsa key pair.

**3.- When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.**
	
	Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]

**4.- At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases".**

	Enter passphrase (empty for no passphrase): [Press enter]
	Enter same passphrase again: [Press enter]

**5.- Copy the SSH key to your clipboard.**

	cat ~/.ssh/id_rsa.pub

**6.- In the upper-right corner of any page, click your profile photo, then click Settings.**

![enter image description here](https://help.github.com/assets/images/help/settings/userbar-account-settings.png)

**7.- In the user settings sidebar, click SSH and GPG keys.**

![enter image description here](https://help.github.com/assets/images/help/settings/settings-sidebar-ssh-keys.png)

**8.- Click New SSH key or Add SSH key.**

![enter image description here](https://help.github.com/assets/images/help/settings/ssh-add-ssh-key.png)

**9.- In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air".**

**10.- Paste your key into the "Key" field.**

![enter image description here](https://help.github.com/assets/images/help/settings/ssh-key-paste.png)

**11.- Click Add SSH key.**

**12.-If prompted, confirm your GitHub password.**

**13.- Clone repository**

	git clone https://github.com/comet-fmat/comet-install.git
	cd comet-install/
**14.- Execute**

	./install-comet.sh
