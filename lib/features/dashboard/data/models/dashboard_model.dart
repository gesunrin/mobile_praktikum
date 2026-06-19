class DashboardStats {
  final String title;
  final String value;
  final String subtitle;

  DashboardStats({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      title: json['title'] ?? '',
      value: json['value'].toString(),
      subtitle: json['subtitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'subtitle': subtitle,
    };
  }
}

class DashboardData {
  final String username;
  final List<DashboardStats> stats;
  final DateTime lastUpdate;

  DashboardData({
    required this.username,
    required this.stats,
    required this.lastUpdate,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      username: json['username'] ?? 'User',
      stats: (json['stats'] as List)
          .map((e) => DashboardStats.fromJson(e))
          .toList(),
      lastUpdate: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'stats': stats.map((e) => e.toJson()).toList(),
      'lastUpdate': lastUpdate.toIso8601String(),
    };
  }

  DashboardData copyWith({
    String? username,
    List<DashboardStats>? stats,
    DateTime? lastUpdate,
  }) {
    return DashboardData(
      username: username ?? this.username,
      stats: stats ?? this.stats,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}