import 'dart:async';

// Minimal ProdukBloc implementation to satisfy usages in the UI.
// Replace with real API / repository logic as needed.
class ProdukBloc {
  /// Deletes a product by id. This is a placeholder implementation.
  /// Return type matches usage in the UI (Future) so callers can await/then.
  static Future<void> deleteProduk({required int id}) async {
    // TODO: implement actual delete (HTTP request / database).
    // For now simulate work and succeed. To simulate failure, throw an error.
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
