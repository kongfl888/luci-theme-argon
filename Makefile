#
# Copyright (C) 2020 kongfl888<kongfl888@outlook.com>
# https://github.com/kongfl888
# GPL 3.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-theme-argon

LUCI_TITLE:=Argon Theme
PKG_VERSION:=2.01
PKG_RELEASE:=20.029
PKG_DATE:=20200701

PKG_MAINTAINER:=kongfl888 <kongfl888@outlook.com>
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  CATEGORY:=LuCI
  SUBMENU:=4. Themes
  TITLE:=Argon Theme
  PKGARCH:=all
  DEPENDS:=+luci
endef

define Package/$(PKG_NAME)/description
	LuCI Argon Theme
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	cp ./root/etc/uci-defaults/30_luci-theme-argon $(1)/etc/uci-defaults/30_luci-theme-argon

	$(INSTALL_DIR) $(1)/www
	cp -pR ./htdocs/* $(1)/www

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/

endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
    chmod a+x $${IPKG_INSTROOT}/etc/uci-defaults/30_luci-theme-argon >/dev/null 2>&1
    sh $${IPKG_INSTROOT}/etc/uci-defaults/30_luci-theme-argon && rm -f $${IPKG_INSTROOT}/etc/uci-defaults/30_luci-theme-argon || echo ""
    rm -rf /tmp/luci-modulecache/ >/dev/null 2>&1 || echo ""
    rm -f /tmp/luci-indexcache >/dev/null 2>&1 || echo ""
    exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
    rm -rf /etc/uci-defaults/30_luci-theme-argon >/dev/null 2>&1 || echo ""
    exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
