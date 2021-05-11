FROM rapi/psgi:1.3400
MAINTAINER Henry Van Styn <vanstyn@cpan.org>

# --
# rapi/psgi "stack" version is psgi-1.3400-a0-04:
#
#   psgi-1.3400 : based on rapi/psgi:1.3400
#   a0          : this docker image is named "rapi/psgi-stack-a0"
#   04          : sub version 04
#
# This is an informational/convention only datapoint:
ENV RAPI_PSGI_EXTENDED_STACK_VERSION=psgi-1.3400-a0-04
# --

#
# Current stack "A0" libs, in no particular order:
#

# Install Debian packages noninteractively.
ARG DEBIAN_FRONTEND=noninteractive

# Install rapi-psgi extras.
RUN rapi-install-extras

# Update apt-get metadata.
RUN apt-get update

# Upgrade existing packages to the latest versions.
RUN apt-get -y upgrade

# Install additional packages of interest.
RUN apt-get -y install \
  less \
  man-db \
  postgresql-common \
&& :

# Setup PostgreSQL apt repository.
RUN echo "" | /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# Install latest PostgreSQL client.
RUN apt-get -y install postgresql-client

# ironically pull later RapidApp for now (to get 1.3401)
RUN cpanm RapidApp && rm -rf ~/.cpanm/

# packages which fail tests and currently must be force installed:
RUN cpanm --notest --force \
  Amazon::MWS \
  Amazon::MWS::Client \
  Net::Server \
  Term::ReadLine::Perl \
&& rm -rf ~/.cpanm/

# packages which install properly
RUN cpanm \
  Archive::Zip \
  aliased \
  Benchmark::Timer \
  Carp::Always \
  CGI::Expand \
  Config::Settings \
  DateTime \
  DateTime::Format::Duration \
  DateTime::Format::Flexible \
  DateTime::Format::Pg \
  DBD::Pg \
  DBIx::Class::Candy \
  DBIx::Class::Cursor::Cached \
  DBIx::Class::Helper::Row::SelfResultSet \
  DBIx::Class::Helpers \
  DBIx::Class::QueryLog \
  DBIx::Class::ResultDDL \
  DBIx::Class::TimeStamp \
  DBIx::Class::AuditAny \
  DBIx::Class::Helpers \
  DBIx::Class::Schema::Diff \
  DBIx::Class::StateMigrations \
  DBIx::Class::TimeStamp \
  Devel::Confess \
  Devel::DDCWarn \
  HTTP::Request \
  HTTP::Request::AsCGI \
  JSON \
  lib::relative \
  Lingua::EN::Nickname \
  Log::Any \
  Log::Contextual::WarnLogger \
  Math::PercentChange \
  Moo \
  Moose \
  MooseX::AttributeShortcuts \
  MooseX::Types::LoadableClass \
  MooseX::Types::Moose \
  Net::LDAP \
  Package::Stash \
  PadWalker \
  Parallel::ForkManager \
  Path::Class \
  Plack::Middleware \
  RapidApp::Util \
  String::TT \
  Text::Trim \
  Tie::Hash::Indexed \
  Text::Trim \
  Type::Tiny \
  YAML \
  HTML::Diff \
  Catalyst::Plugin::RunAfterRequest \
  Catalyst::Plugin::SimpleCAS \
  Data::Dump \
  Data::Dx \
  Data::Printer \
  Data::TableReader \
  DateTime::Format::Flexible \
  Devel::NYTProf \
  Digest::SHA1 \
  Email::Address \
  Email::MIME::CreateHTML \
  Email::Sender \
  HTML::Diff \
  HTML::Entities \
  HTML::FormatText::WithLinks \
  HTML::FromANSI \
  JSON::XS \
  LWP::UserAgent \
  Log::Any \
  Log::Any::Adapter::Daemontools \
  Log::Any::Adapter::TAP \
  Plack::Builder \
  Spreadsheet::ParseExcel \
  Spreadsheet::ParseXLSX \
  Starman \
  Term::ReadKey \
  Term::ReadLine \
  Term::Size::Any \
  Text::CSV_XS \
  Text::Trim \
  Tie::Hash::Indexed \
  Try::Tiny \
  WebService::Mattermost \
  YAML::XS \
&& rm -rf ~/.cpanm/


RUN cpanm http://www.cpan.org/authors/id/V/VA/VANSTYN/DBIC-Violator-0.900.tar.gz && rm -rf .cpanm/
