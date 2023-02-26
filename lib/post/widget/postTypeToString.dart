String postTypeToString(int? postType) {
  if (postType == 3) {
    return 'KTX';
  } else if (postType == 1) {
    return '택시';
  } else if (postType == 2) {
    return '카풀';
  } else {
    return 'error';
  }
}
