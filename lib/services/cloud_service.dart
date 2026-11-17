import 'dart:convert';
import 'package:http/http.dart' as http;

/// WorkBuddy 云服务客户端
/// 使用 publicConfig 中的 endpoint 和 publishableKey 进行初始化
/// 部署后由 workbuddy_cloud_service 工具返回的 publicConfig 填入
class CloudService {
  // 这些值在激活云服务后由 publicConfig 提供
  // 在实际部署时替换为真实值
  static String endpoint = '';       // 从 publicConfig.endpoint 获取
  static String publishableKey = ''; // 从 publicConfig.publishableKey 获取
  static String oauthRelayBaseUrl = ''; // 从 publicConfig.oauthRelayBaseUrl 获取

  static final CloudService _instance = CloudService._internal();
  factory CloudService() => _instance;
  CloudService._internal();

  /// 初始化云服务配置
  static void init({
    required String ep,
    required String pk,
    String? oauthRelay,
  }) {
    endpoint = ep;
    publishableKey = pk;
    oauthRelayBaseUrl = oauthRelay ?? '';
  }

  /// 用户注册
  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$endpoint/.cloud/auth/v1/sign-up'),
      headers: _headers(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _handleResponse(response);
  }

  /// 用户登录
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$endpoint/.cloud/auth/v1/sign-in'),
      headers: _headers(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _handleResponse(response);
  }

  /// 保存算命记录到数据库
  Future<Map<String, dynamic>> saveFortuneRecord(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$endpoint/.cloud/database/rest/fortune_records'),
      headers: _headers(),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  /// 查询用户历史记录
  Future<List<Map<String, dynamic>>> getFortuneRecords(String userId) async {
    final response = await http.get(
      Uri.parse('$endpoint/.cloud/database/rest/fortune_records?filter=user_id:eq:$userId&order=created_at:desc&limit=50'),
      headers: _headers(),
    );
    final result = _handleResponse(response);
    if (result['success'] == true && result['data'] is List) {
      return List<Map<String, dynamic>>.from(result['data']);
    }
    return [];
  }

  /// 调用 LLM 生成算命分析
  Future<String> getLLMAnalysis(String prompt) async {
    final response = await http.post(
      Uri.parse('$endpoint/.cloud/llm/chat/completions'),
      headers: _headers(),
      body: jsonEncode({
        'messages': [
          {'role': 'system', 'content': '你是一位精通中国传统文化命理学、西方占星学和塔罗牌解读的大师。请根据用户提供的信息，给出专业、温和、积极向上的命理分析和建议。回复请使用中文。'},
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.8,
        'max_tokens': 1500,
      }),
    );
    final result = _handleResponse(response);
    if (result['success'] == true) {
      final choices = result['data']?['choices'];
      if (choices is List && choices.isNotEmpty) {
        return choices[0]['message']['content'] ?? '';
      }
    }
    return '分析结果暂时不可用，请稍后再试。';
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $publishableKey',
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'success': true, 'data': body};
      }
      return {'success': false, 'error': body['message'] ?? '请求失败'};
    } catch (e) {
      return {'success': false, 'error': '解析响应失败: $e'};
    }
  }
}
