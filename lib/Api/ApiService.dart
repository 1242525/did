import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl ='http://220.149.235.79:5000';
  static String address= '';


  //Did발급하기
  Future<Map<String, dynamic>?> issueDid(String label) async {
    final url = Uri.parse('$baseUrl/did/create');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"label": label}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          return decoded;
        }else {
          print("응답 타입 오류: $decoded");
          return null;
        }
      } else {
        print('응답 실패: ${response.statusCode}');
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
      return null;
    }
  }

  //Did조회하기
  Future<Map<String, dynamic>?> checkDid() async {
    final url = Uri.parse('$baseUrl/did/dids');

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          return decoded;
        }else {
          print("응답 타입 오류: $decoded");
          return null;
        }
      } else {
        print('응답 실패: ${response.statusCode}');
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
      return null;
    }
  }

  // DID 삭제
  Future<bool> deleteDid(String did) async {
    final url = Uri.parse('$baseUrl/did/delete');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"label": did}), // 조회되는 did 값 전달
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("삭제 성공: ${response.body}");
        return true;
      } else {
        print("삭제 실패: ${response.statusCode}");
        return false;
      }
    } catch (e, stack) {
      print("예외 발생: $e");
      print(stack);
      return false;
    }
  }


//Did 상세정보
  Future<Map<String, dynamic>?> detailDid(String did) async{
    final url= Uri.parse('$baseUrl/did/resolve');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"label": did}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          return decoded;
        }else {
          print("응답 타입 오류: $decoded");
          return null;
        }
      } else {
        print('응답 실패: ${response.statusCode}');
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
      return null;
    }
  }

  //VC 발급
  Future<Map<String, dynamic>?> issueVC({
    required String issuer,
    required String subject,
    required Map<String, dynamic>? claims,
    required int ttl,
    required String aud

}) async{
    final url= Uri.parse('$baseUrl/did/issue-vc');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "issuer" : issuer,
          "subject": subject,
          "claims" : claims,
          "ttl": ttl,
          "aud" : aud
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          return decoded;
        }else {
          print("응답 타입 오류: $decoded");
          return null;
        }
      } else {
        print('응답 실패: ${response.statusCode}');
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
      return null;
    }
  }

  //vp 생성
  Future <String?> issueVP({
    required String holder,
    required List vc_jwts
}
      )async {
    final url = Uri.parse('$baseUrl/did/present-vp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "holder": holder,
          "vc_jwts": vc_jwts
        }),
      );

      if (response.statusCode >= 200 && response.statusCode<=300) {
        print('응답: ${response.body}');
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생 : $e');
      print(stack);
      return null;
    }
  }

  // VC 검증
  Future<String?> verifyVC({
    required String vc_jwt
})async{
    final url=Uri.parse('$baseUrl/verify-vc');

    try{
    final response= await http.post(url,
    headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "vc_jwt": vc_jwt


      }),
    );

    if(response.statusCode>=200 && response.statusCode<=300) {
      print('응답: ${response.body}');
      return jsonDecode(response.body);
    }else{
      return null;

    }
  }catch(e, stack){
      print('예외발생: $e');
      print(stack);
    }

  }

  // vp 검증
  Future<String?> verifyVp({
    required String vp_jwt
})async {
    final url = Uri.parse('$baseUrl/did/verify-vp');

    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "vp_jwt": vp_jwt

        }),

      );
      if (response.statusCode >= 200 && response.statusCode<=300) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생 : $e');
      print(stack);
    }
  }

  Future<String?> verifyVP()async {
    final url = Uri.parse('$baseUrl/');

    try {
      final response = await http.post(url,
        headers: {'content-Type': 'applications/json'},
        body: jsonEncode({}),
      );
      if (response.statusCode == 200) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
    }
  }
}
