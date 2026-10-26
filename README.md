Hello, this is the source code for a project I was working on during my junior year and the summer before senior year!

# DESCRIPTION:
    The purpose of this project was to experiment with gameplay systems for a future mecha combat game. Development was paused due to other commitments, so the project is still in its early stages. Inspired by games like Armored Core, the envisioned gameplay features a camera lock-on system that tracks nearby enemies, while also being able to attack with their equipped weapon. 

    A player can press shift to auto-lock onto the closest enemy. When a weapon is equipped, left-clicking allows them to quickly redirect their camera and character towards the nearest enemy. This required a system that stores and tracks weapon loadouts, allowing players to swap between different weapons. While modules store data, server-side scripts extract this data and put it to use. The Roblox tool system was inconsistent and difficult to control, so I experimented with animations to control the orientation of the weapon. This will allow me to have full control of weapon movement for attacking animations in the future. Modules were used to automate camera movement and calculations for enemy positions, and player scripts recieved inputs to decide which type of camere-locking was necessary.

# FOLDERS:
    ReplicatedStorage - contains modules, which can be accessed and shared by local and server scripts
    ServerScriptService - contains server-side scripts
    StarterCharacterScripts - contains local scripts 

# REPOSITORY LIMITATIONS:
    This repository was created after the project's development, which was carried out entirely in Roblox Studio. As a result, it does not contain a version history or document the project's development process. It provides the available scripts and their general hierarchy within the project. Other instances and assets used outside of the repository include events, weapon models, animations, and GUI's. 

    Although tools exist to synchronize Roblox projects and their environments with vs-code and github, these tools must be configured during the project's development. Since I was unaware of them, I am unable to provide a complete version history or a reconstruction of the original project structure.



