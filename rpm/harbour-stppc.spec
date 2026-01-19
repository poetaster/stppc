Name:       harbour-stppc

# >> macros
%define _binary_payload w2.xzdio
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    Simon Tatham's Portable Puzzle Collection
Version:    0.2.0
Release:    1
License:    MIT
BuildArch:  noarch
URL:        https://www.chiark.greenend.org.uk/~sgtatham/puzzles/
Source0:    %{name}-%{version}.tar.bz2
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   libsailfishapp-launcher
Requires:   sailfish-components-webview-qt5

BuildRequires:  pkgconfig(sailfishapp) >= 1.0.3
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
A selection of Simon Tatham's Portable Puzzle Collection Sailfish OS QML wrapper app.
%if "%{?vendor}" == "chum"
PackageName: stppc
Type: desktop-application
Categories:
 - Game
DeveloperName: Simon Tatham
Custom:
 - Repo: https://github.com/poetaster/stppc
Icon: https://raw.githubusercontent.com/poetaster/stppc/master/icons/172x172/harbour-stppc.png
Screenshots:
 - https://raw.githubusercontent.com/poetaster/stppc/master/screen-1.png
 - https://raw.githubusercontent.com/poetaster/stppc/master/screen-2.png
 - https://raw.githubusercontent.com/poetaster/stppc/master/screen-3.png
%endif

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5 

%make_build


%install
%qmake5_install


desktop-file-install --delete-original         --dir %{buildroot}%{_datadir}/applications                %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%defattr(0644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
