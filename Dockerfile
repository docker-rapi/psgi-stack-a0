FROM rapi/psgi:1.3500
MAINTAINER Henry Van Styn <vanstyn@cpan.org>

# --
# rapi/psgi "stack" version is psgi-1.3500-a0-01:
#
#   psgi-1.3500 : based on rapi/psgi:1.3500
#   a0          : this docker image is named "rapi/psgi-stack-a0"
#   01          : sub version 01
#
# This is an informational/convention only datapoint:
ENV RAPI_PSGI_EXTENDED_STACK_VERSION=psgi-1.3500-a0-01
#
# Standard environment variables:
ENV SHELL="/bin/bash"
ENV USER="root"
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
  colordiff \
  less \
  libterm-readkey-perl \
  man-db \
  postgresql-common \
  strace \
  ripgrep \
&& :

# Setup PostgreSQL apt repository.
RUN echo "" | /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# Install latest PostgreSQL client.
RUN apt-get -y install postgresql-client

# packages which fail tests and currently must be force installed:
RUN cpanm --notest --force \
  Furl \
  Net::Server \
  OAuth2::Google::Plus \
  Plack::App::Proxy \
  Schedule::Cron \
  Term::ReadLine::Perl \
&& rm -rf ~/.cpanm/

RUN cpanm Lingua::JA::Romanize::Japanese \
  || ( \
    cd ~/.cpanm/latest-build/Lingua-JA-Romanize-Japanese-0.23 \
    && perl -pi -e 's/openlab\.jp/openlab.ring.gr.jp/g' README make-dist.sh \
      lib/Lingua/JA/Romanize/DictJA.pm \
      lib/Lingua/JA/Romanize/Japanese.pm \
    && perl Makefile.PL && make && make test && make install \
  ) </dev/null \
  && rm -rf ~/.cpanm/

# packages which install properly
RUN cpanm \
  Algorithm::CheckDigits \
  aliased \
  Amazon::MWS \
  Amazon::MWS::Client \
  Archive::Zip \
  Benchmark::Timer \
  Carp::Always \
  Catalyst::Plugin::RunAfterRequest \
  Catalyst::Plugin::SimpleCAS \
  CatalystX::OAuth2 \
  CGI::Expand \
  Config::Settings \
  Data::Dump \
  Data::Dx \
  Data::Printer \
  Data::TableReader \
  Data::TableReader::Decoder::HTML \
  Data::XLSX::Parser \
  Date::RetentionPolicy \
  DateTime \
  DateTime::Format::Duration \
  DateTime::Format::Flexible \
  DateTime::Format::Pg \
  DBD::Pg \
  DBIx::Class::AuditAny \
  DBIx::Class::Candy \
  DBIx::Class::Cursor::Cached \
  DBIx::Class::Helper::Row::SelfResultSet \
  DBIx::Class::Helpers \
  DBIx::Class::QueryLog \
  DBIx::Class::ResultDDL \
  DBIx::Class::Schema::Diff \
  DBIx::Class::StateMigrations \
  DBIx::Class::TimeStamp \
  Devel::Confess \
  Devel::DDCWarn \
  Devel::NYTProf \
  Devel::Size \
  Digest::MD5 \
  Digest::SHA1 \
  Email::Address \
  Email::MIME::CreateHTML \
  Email::Sender \
  Email::Valid \
  Google::API::OAuth2::Client \
  Google::OAuth2::Client::Simple \
  HTML::Diff \
  HTML::Entities \
  HTML::FormatText::WithLinks \
  HTML::FromANSI \
  HTML::FromText \
  HTTP::Request \
  HTTP::Request::AsCGI \
  JSON \
  JSON::XS \
  lib::relative \
  Lingua::EN::Nickname \
  Log::Any \
  Log::Any::Adapter::Daemontools \
  Log::Any::Adapter::TAP \
  Log::Contextual::WarnLogger \
  Log::Log4perl \
  LWP::Authen::OAuth2 \
  LWP::UserAgent \
  Math::PercentChange \
  Mojolicious::Plugin::OAuth2 \
  Moo \
  Moose \
  MooseX::AttributeShortcuts \
  MooseX::FileAttribute \
  MooseX::SimpleConfig \
  MooseX::Types::LoadableClass \
  MooseX::Types::Moose \
  Net::LDAP \
  Net::OAuth2 \
  Net::OAuth2::AuthorizationServer \
  Net::OAuth2::Moosey::Client \
  Net::OAuth2::Scheme \
  OAuth2::Google::Plus \
  Package::Stash \
  PadWalker \
  Parallel::ForkManager \
  Path::Class \
  PDF::API2 \
  PDF::Data \
  Plack::Builder \
  Plack::Middleware \
  Plack::Middleware::Auth::OAuth2::ProtectedResource \
  Plack::Middleware::Debug::Profiler::NYTProf \
  Plack::Middleware::OAuth \
  Plack::Middleware::Profiler::NYTProf \
  RapidApp::Util \
  Spreadsheet::ParseExcel \
  Spreadsheet::ParseXLSX \
  Starman \
  String::TT \
  Syntax::Keyword::Try \
  Task::Catalyst \
  Task::HTML5 \
  Task::Kensho::ExcelCSV \
  Task::Kensho::ModuleDev \
  Task::Kensho::OOP \
  Task::Kensho::WebCrawling \
  Task::Kensho::WebDev \
  Task::Kensho::XML \
  Task::Plack \
  Task::Unicode \
  Term::ReadKey \
  Term::ReadLine \
  Term::Size::Any \
  Test::Postgresql58 \
  Text::CSV_XS \
  Text::Password::Pronounceable \
  Text::Trim \
  Tie::FS \
  Tie::Hash::Indexed \
  Time::Moment \
  Try::Tiny \
  Type::Tiny \
  WebService::Mattermost \
  WWW::Scripter \
  YAML \
  YAML::XS \
&& rm -rf ~/.cpanm/

RUN cpanm http://www.cpan.org/authors/id/V/VA/VANSTYN/DBIC-Violator-0.900.tar.gz && rm -rf .cpanm/


## docker-build command refernce:
#
# time docker build -t rapi/psgi-stack-a0 .
# docker tag rapi/psgi-stack-a0 rapi/psgi-stack-a0:psgi-1.3500-a0-01
# docker push rapi/psgi-stack-a0
#

