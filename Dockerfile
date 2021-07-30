FROM rapi/psgi:1.3400
MAINTAINER Henry Van Styn <vanstyn@cpan.org>

# --
# rapi/psgi "stack" version is psgi-1.3400-a0-05:
#
#   psgi-1.3400 : based on rapi/psgi:1.3400
#   a0          : this docker image is named "rapi/psgi-stack-a0"
#   05          : sub version 05
#
# This is an informational/convention only datapoint:
ENV RAPI_PSGI_EXTENDED_STACK_VERSION=psgi-1.3400-a0-05
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
  aliased \
  Archive::Zip \
  Benchmark::Timer \
  Carp::Always \
  Catalyst::Plugin::RunAfterRequest \
  Catalyst::Plugin::SimpleCAS \
  CGI::Expand \
  Config::Settings \
  Data::Dump \
  Data::Dx \
  Data::Printer \
  Data::TableReader \
  DateTime \
  DateTime::Format::Duration \
  DateTime::Format::Flexible \
  DateTime::Format::Flexible \
  DateTime::Format::Pg \
  DBD::Pg \
  DBIx::Class::AuditAny \
  DBIx::Class::Candy \
  DBIx::Class::Cursor::Cached \
  DBIx::Class::Helper::Row::SelfResultSet \
  DBIx::Class::Helpers \
  DBIx::Class::Helpers \
  DBIx::Class::QueryLog \
  DBIx::Class::ResultDDL \
  DBIx::Class::Schema::Diff \
  DBIx::Class::StateMigrations \
  DBIx::Class::TimeStamp \
  DBIx::Class::TimeStamp \
  Devel::Confess \
  Devel::DDCWarn \
  Devel::NYTProf \
  Digest::MD5 \
  Digest::SHA1 \
  Email::Address \
  Email::MIME::CreateHTML \
  Email::Sender \
  Email::Valid \
  HTML::Diff \
  HTML::Diff \
  HTML::Entities \
  HTML::FormatText::WithLinks \
  HTML::FromANSI \
  HTTP::Request \
  HTTP::Request::AsCGI \
  JSON \
  JSON::XS \
  lib::relative \
  Lingua::EN::Nickname \
  Log::Any \
  Log::Any \
  Log::Any::Adapter::Daemontools \
  Log::Any::Adapter::TAP \
  Log::Contextual::WarnLogger \
  LWP::UserAgent \
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
  Plack::Builder \
  Plack::Middleware \
  RapidApp::Util \
  Spreadsheet::ParseExcel \
  Spreadsheet::ParseXLSX \
  Starman \
  String::TT \
  Term::ReadKey \
  Term::ReadLine \
  Term::Size::Any \
  Text::CSV_XS \
  Text::Password::Pronounceable \
  Text::Trim \
  Text::Trim \
  Text::Trim \
  Tie::Hash::Indexed \
  Tie::Hash::Indexed \
  Try::Tiny \
  Type::Tiny \
  WebService::Mattermost \
  YAML \
  YAML::XS \
&& rm -rf ~/.cpanm/

RUN cpanm http://www.cpan.org/authors/id/V/VA/VANSTYN/DBIC-Violator-0.900.tar.gz && rm -rf .cpanm/
