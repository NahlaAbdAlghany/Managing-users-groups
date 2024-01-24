#!/bin/bash

#************Functions************
# Function to create a user
create_user() {
    read -p "Enter username: " username
    useradd $username
    echo "User $username created successfully."
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    userdel $username
    echo "User $username deleted successfully."
}

# Function to modify a user
modify_user() {

	PS3="Select>>: "

 select opt in "Change Home Directory" "Change Shell" "Exit"; do
    case $opt in
        "Change Home Directory")
            read -p "Enter username to modify: " username;
            read -p "Enter the new home directory: " new_home_directory;
            usermod -d "$new_home_directory" "$username";
            echo "Home directory changed successfully for user: $username";

            ;;
        "Change Shell")
		 read -p "Enter the username: " username
		 read -p "Enter the new shell: " new_shell
		 usermod -s "$new_shell" "$username"
		 echo "Shell changed successfully for user: $username"

            ;;
        "Exit")
            echo "Exiting script."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done

}

# Function to create a group
create_group() {
    read -p "Enter group name: " groupname
    groupadd $groupname
    echo "Group $groupname created successfully."
}

# Function to delete a group
delete_group() {
    read -p "Enter group name to delete: " groupname
    groupdel $groupname
    echo "Group $groupname deleted successfully."
}

# Function to modify a group
modify_group() {
    read -p "Enter group name to modify: " groupname
    PS3="Select >> "

    select option in "Change Group Name" "Add User to Group" "Remove User from Group" "Exit"; do
        case $option in
            "Change Group Name")
                read -p "Enter the new group name: " new_groupname
                groupmod -n "$new_groupname" "$groupname"
                echo "Group name changed successfully from $groupname to $new_groupname"
                ;;
            "Add User to Group")
                read -p "Enter the username to add to the group: " username
                usermod -aG "$groupname" "$username"
                echo "User $username added to group $groupname"
                ;;
            "Remove User from Group")
                read -p "Enter the username to remove from the group: " username
                gpasswd -d "$username" "$groupname"
                echo "User $username removed from group $groupname"
                ;;
            "Exit")
                echo "Exiting group modification."
                break
                ;;
            *)
                echo "please enter valid option number "
                ;;
        esac
    done
}

user_menu() {
    echo "        User Menu            "
    echo "1. Create User"
    echo "2. Modify User"
    echo "3. Delete User"
    echo "4. Back to Main Menu"
}

# Function to display the group menu
group_menu() {
    echo "        Group Menu           "
    echo "1. Create Group"
    echo "2. Modify Group"
    echo "3. Delete Group"
    echo "4. Back to Main Menu"
}

#*************main*************************

while true; do
    PS3="Select >>"
    select option in "User management" "Group management" "Exit"; do
        case $option in
        "User management")
            while true; do
                user_menu
                read -p "Enter your choice : " choice
                case $choice in
                1) create_user ;;
                2) modify_user ;;
                3) delete_user ;;
                4) break ;;
                *) echo " please enter valid choice number" ;;
                esac
            done
            ;;
        "Group management")
            while true; do
                group_menu
                read -p "Enter your choice : " choice
                case $choice in
                1) create_group ;;
                2) modify_group ;;
                3) delete_group ;;
                4) break ;;
                *) echo " please enter valid choice number" ;;
                esac
            done
            ;;
        "Exit")
            echo "Thank you for using Program "
            exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 3." ;;
        esac
        break
    done
done

