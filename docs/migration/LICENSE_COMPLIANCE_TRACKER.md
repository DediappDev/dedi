# License Compliance Tracker

**Purpose**: Track license compliance for all mirrored dependencies  
**Status**: 🚧 In Progress  
**Owner**: _To be assigned_  
**Last Review**: _To be filled_

## Summary

| License Type | Count | Risk Level | Compliance Status |
|--------------|-------|------------|-------------------|
| Apache 2.0 | TBD | ✅ Low | ⏳ Pending Review |
| MIT | TBD | ✅ Low | ⏳ Pending Review |
| BSD | TBD | ✅ Low | ⏳ Pending Review |
| AGPL/GPL | TBD | ⚠️ Medium-High | ⏳ Pending Review |
| Custom/Proprietary | TBD | ⚠️ High | ⏳ Pending Review |
| Unknown | TBD | ❌ Critical | ⏳ Pending Review |

## Git Repository Dependencies

### Linagora Repositories

| Repository | License | Commercial Use | Modification | Distribution | Notes |
|------------|---------|----------------|--------------|--------------|-------|
| matrix-dart-sdk | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| receive_sharing_intent | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| linagora-design-flutter | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| flutter_matrix_html | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| flutter_contacts | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| inview_notifier_list | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| future-loading-dialog | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| linkfy_text | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| emoji_mart | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| social_media_recorder | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| matrix_link_text | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |
| dart_matrix_api_lite | ⏳ TBD | ⏳ | ⏳ | ⏳ | Check LICENSE file |

### Third-Party Repositories

| Repository | License | Commercial Use | Modification | Distribution | Notes |
|------------|---------|----------------|--------------|--------------|-------|
| VideoCompress | ⏳ TBD | ⏳ | ⏳ | ⏳ | SpectoraSoftware |
| video_thumbnail | ⏳ TBD | ⏳ | ⏳ | ⏳ | maRci002 |
| fcm_shared_isolate | ⏳ TBD | ⏳ | ⏳ | ⏳ | famedly |
| flutter_app_badger | ⏳ TBD | ⏳ | ⏳ | ⏳ | bitsydarel |
| skeletons | ⏳ TBD | ⏳ | ⏳ | ⏳ | alirezat66 |
| image_gallery_saver | ⏳ TBD | ⏳ | ⏳ | ⏳ | FlutterStudioIst |
| dart_native_imaging | ⏳ TBD | ⏳ | ⏳ | ⏳ | famedly |
| keyboard_shortcuts | ⏳ TBD | ⏳ | ⏳ | ⏳ | zhouzhuo810 |

### Matrix.org Repositories

| Repository | License | Commercial Use | Modification | Distribution | Notes |
|------------|---------|----------------|--------------|--------------|-------|
| olm | Apache 2.0 (likely) | ✅ Yes | ✅ Yes | ✅ Yes | Check at gitlab.matrix.org |

### iOS Swift Packages

| Repository | License | Commercial Use | Modification | Distribution | Notes |
|------------|---------|----------------|--------------|--------------|-------|
| Version | ⏳ TBD | ⏳ | ⏳ | ⏳ | mxcl |
| swift-collections | Apache 2.0 | ✅ Yes | ✅ Yes | ✅ Yes | Apple official |
| Prefire | ⏳ TBD | ⏳ | ⏳ | ⏳ | BarredEwe |
| DTCoreText | BSD (likely) | ⏳ | ⏳ | ⏳ | Cocoanetics |
| DeviceKit | MIT (likely) | ⏳ | ⏳ | ⏳ | devicekit |
| matrix-rust-components-swift | Apache 2.0 (likely) | ⏳ | ⏳ | ⏳ | matrix-org |
| LRUCache | ⏳ TBD | ⏳ | ⏳ | ⏳ | nicklockwood |
| KeychainAccess | MIT (likely) | ⏳ | ⏳ | ⏳ | kishikawakatsumi |
| Kingfisher | MIT | ✅ Yes | ✅ Yes | ✅ Yes | onevcat |

## Docker Images

| Image | Base License | Distribution Rights | Notes |
|-------|--------------|---------------------|-------|
| nixos/nix:2.22.1 | LGPL 2.1 | ⚠️ Review | Nix package manager |
| instrumentisto/flutter:3.27.4 | BSD (Flutter) | ✅ Yes | Based on Flutter SDK |
| nginx:alpine | BSD 2-Clause | ✅ Yes | Nginx license |
| matrixdotorg/synapse:latest | Apache 2.0 | ✅ Yes | Matrix.org project |

## NPM Packages

| Package | License | Commercial Use | Notes |
|---------|---------|----------------|-------|
| adm-zip@^0.5.10 | MIT | ✅ Yes | Archive manipulation |
| curlrequest@^1.0.1 | ⏳ TBD | ⏳ | HTTP requests |
| read-yaml-file@^2.1.0 | MIT (likely) | ⏳ | YAML parser |
| request@^2.88.2 | Apache 2.0 | ✅ Yes | HTTP client (deprecated) |

## Pub/Dart Packages (Sample - Top 20 by importance)

| Package | License | Commercial Use | Notes |
|---------|---------|----------------|-------|
| http | BSD-3-Clause | ✅ Yes | Dart team package |
| dio | MIT | ✅ Yes | HTTP client |
| hive | Apache 2.0 | ✅ Yes | Local database |
| get_it | MIT | ✅ Yes | Service locator |
| rxdart | Apache 2.0 | ✅ Yes | Reactive extensions |
| _...100+ more packages..._ | ⏳ TBD | ⏳ | Run `flutter pub deps` |

## Compliance Actions Required

### High Priority ⚠️

- [ ] **Linagora Repositories**: Contact Linagora for license clarification
  - Determine if AGPL/GPL or commercial-friendly license
  - Verify redistribution and modification rights
  - Document any usage restrictions

- [ ] **Matrix OLM Library**: Review export control regulations
  - Cryptography export compliance
  - International distribution considerations
  - Document any restrictions

- [ ] **Unknown Licenses**: Identify and document all packages
  - Run automated license detection
  - Manual review for custom licenses
  - Contact authors if unclear

### Medium Priority ⚠️

- [ ] **Swift Packages**: Verify licenses for all iOS dependencies
  - Check LICENSE files in each repo
  - Document compatibility with proprietary use
  - Note any attribution requirements

- [ ] **Third-Party Repos**: Contact authors for license confirmation
  - Especially for packages without clear LICENSE file
  - Document any special permissions needed
  - Note fork vs mirror considerations

### Low Priority ✅

- [ ] **Well-Known Licenses**: Document standard permissive licenses
  - MIT, Apache 2.0, BSD variants
  - Note attribution requirements
  - Prepare license aggregation for app

## License Checking Commands

```bash
# Check license in git repository
git clone REPO_URL temp_check
cat temp_check/LICENSE
cat temp_check/README.md | grep -i license

# NPM packages
npm view PACKAGE_NAME license

# Pub packages  
curl https://pub.dev/api/packages/PACKAGE_NAME | jq '.latest.pubspec.license'

# CocoaPods
pod spec cat PACKAGE_NAME | grep license

# Automated tools
npm install -g license-checker
license-checker --json > licenses.json
```

## Export Control Compliance

### Cryptographic Components

| Component | Type | Export Control | Status |
|-----------|------|----------------|--------|
| OLM Library | E2E Encryption | ⚠️ Review Required | ⏳ Pending |
| Flutter Crypto | Standard Crypto | ⚠️ Review Required | ⏳ Pending |
| TLS/SSL | Transport Security | ✅ Generally Exempt | ⏳ Verify |

**Action Items**:
- [ ] Review US export control regulations (EAR)
- [ ] Review EU export control regulations
- [ ] Check country-specific restrictions
- [ ] Document encryption usage in compliance docs
- [ ] Obtain legal counsel if needed

## Attribution Requirements

### Required Attributions

Document any licenses requiring attribution in the app:

| Package | License | Attribution Required | Location in App |
|---------|---------|---------------------|-----------------|
| _TBD_ | _TBD_ | _TBD_ | _TBD_ |

### Attribution File Location
- Mobile: `about` screen or settings
- Web: Footer or separate licenses page
- File: Create `THIRD_PARTY_LICENSES.md` in docs

## Risk Assessment

### Low Risk ✅
- MIT, Apache 2.0, BSD licenses
- Well-documented commercial use permissions
- Standard FOSS licenses

### Medium Risk ⚠️
- Custom licenses requiring review
- Packages without clear license documentation
- Dependencies with unknown sublicenses

### High Risk ❌
- AGPL/GPL without commercial exception
- Proprietary licenses with restrictions
- Cryptographic components without export clearance
- Packages with unclear redistribution rights

## Compliance Checklist

- [ ] All licenses identified and documented
- [ ] Commercial use verified for all dependencies
- [ ] Modification rights confirmed
- [ ] Redistribution rights confirmed
- [ ] Attribution requirements documented
- [ ] Export control compliance verified
- [ ] Legal review completed
- [ ] License aggregation file created
- [ ] App attribution screen updated
- [ ] Compliance documentation finalized

## Sign-Off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Legal Review | _TBD_ | _TBD_ | _TBD_ |
| Technical Lead | _TBD_ | _TBD_ | _TBD_ |
| Project Manager | _TBD_ | _TBD_ | _TBD_ |
| Compliance Officer | _TBD_ | _TBD_ | _TBD_ |

## References

- [SPDX License List](https://spdx.org/licenses/)
- [Choose a License](https://choosealicense.com/)
- [TLDRLegal](https://tldrlegal.com/)
- [US Export Administration Regulations](https://www.bis.doc.gov/index.php/regulations/export-administration-regulations-ear)
- [Open Source Initiative](https://opensource.org/licenses)

---

**Note**: This is a living document. Update as licenses are verified and new dependencies are added.

