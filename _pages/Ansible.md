## gather info

` ansible localhost -m setup`

## debug

For debugging purposes it can be useful to not just dump hostvars but
also all other variables and group information. You can do this using a
jinja template which you could include in a debug task, like so:

    tasks:
      - name: Dump all vars
        action: template src=templates/dumpall.j2 dest=/tmp/ansible.all

Then in dumpall.j2:

    Module Variables ("vars"):
    --------------------------------
    {{ vars | to_nice_json }}

    Environment Variables ("environment"):
    --------------------------------
    {{ environment | to_nice_json }}

    GROUP NAMES Variables ("group_names"):
    --------------------------------
    {{ group_names | to_nice_json }}

    GROUPS Variables ("groups"):
    --------------------------------
    {{ groups | to_nice_json }}

    HOST Variables ("hostvars"):
    --------------------------------
    {{ hostvars | to_nice_json }}

All credit to [Lester
Wade](https://coderwall.com/p/13lh6w/dump-all-variables)