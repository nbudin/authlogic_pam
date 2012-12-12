# authlogic_pam #

authlogic_pam is a plugin for authlogic that authenticates users using PAM, the Pluggable Authentication Modules framework.  This allows you to easily accept the same usernames and passwords from web sites that you do on the web server itself.

Note that this may carry some significant security risks along with it.  At the very least, you want to be using SSL encryption when sending the actual passwords for user accounts on your web server over the wire.

## Requirements ##

authlogic_pam requires the following to be installed on your server:

* The PAM framework (virtually all Linux distributions include this)
* The rpam gem
* authlogic, of course

h2. Setup

    sudo gem install authlogic rpam authlogic_pam

Note: for version 1.2.0, and for Ruby 1.9 compatibility, use the 'rpam' and 'authlogic_pam' gems from http://github.com/canweriotnow/

In your authlogic-using application, add the following line to config/environment.rb (or wherever you are storing gem dependencies):

    config.gem 'authlogic_pam'

Ensure that your User model contains a string field called "pam_login". The basic authlogic "login", "crypted_password" and "password_salt" fields are unnecessary for PAM (although you may wish to keep them if you have non-PAM users as well).
Create Users for each user you'd like to grant PAM access.  Make sure the "pam_login" field is exactly the same as their PAM username.
In your login form views, add fields for "pam_login" and "pam_password". Also make sure to use references to these fields (rather than "login" and "password") elsewhere in your views, where appropriate.

## Licensing information ##


#### 1.1.0 ####

Copyright (c) 2009-2010 Nat Budin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#### 1.2.0 ####

Copyright (c) 2011 Jason Lewis

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as 
published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.



