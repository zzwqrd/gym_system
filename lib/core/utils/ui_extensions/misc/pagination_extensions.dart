/// =======================
/// 📋 Pagination Extensions
/// =======================

/// 🔹 List Extensions for Pagination
extension PaginationList<T> on List<T> {
  /// إضافة صفحة جديدة للبيانات
  List<T> appendPage(List<T> newPage, {bool allowDuplicates = false}) {
    if (allowDuplicates) return [...this, ...newPage];
    final existing = Set.from(this);
    final merged = [...this];
    for (var item in newPage) {
      if (!existing.contains(item)) {
        merged.add(item);
      }
    }
    return merged;
  }

  /// جلب صفحة من الليست (مفيد مع local data أو mock)
  List<T> getPage(int page, int pageSize) {
    final start = (page - 1) * pageSize;
    if (start >= length) return [];
    final end = (start + pageSize).clamp(0, length);
    return sublist(start, end);
  }

  /// هل وصلنا للنهاية (على حسب حجم الصفحة)
  bool reachedEnd(int pageSize) => length % pageSize != 0;
}

/// =======================
/// 📋 Pagination Result Model
/// =======================
class PageResult<T> {
  final List<T> items;
  final bool hasMore;
  final int currentPage;

  PageResult({
    required this.items,
    required this.hasMore,
    required this.currentPage,
  });
}

/// 🔹 تحويل أي List لصفحة جاهزة
extension PaginationResult<T> on List<T> {
  PageResult<T> toPageResult({required int page, required int pageSize}) {
    final items = getPage(page, pageSize);
    return PageResult<T>(
      items: items,
      hasMore: items.length == pageSize,
      currentPage: page,
    );
  }
}
