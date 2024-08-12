abstract class NotificationRepository {
  Future<void> initialize();
  Future<String?> getFCMToken();
  Future<void> requestNotificationPermissions();
}
