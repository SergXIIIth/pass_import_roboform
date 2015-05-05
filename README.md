# pass_import_roboform
Script for move [RoboForm](http://www.roboform.com/) passwords to [pass](http://www.passwordstore.org/).

## Usage

1. Save roboform print lists (like `File > Print lists > Logins`)
to `~/roboform_print_lists`.

2. Run import

```bash
  mv ~/.password-store/.git ~/.password-store/.turn_off_git
  ./pass_import_roboform.rb ~/roboform_print_lists
  mv ~/.password-store/.turn_off_git ~/.password-store/.git
```
