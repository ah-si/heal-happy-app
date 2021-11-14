# heal_happy_sdk.api.AuthApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://localhost:3443*

Method | HTTP request | Description
------------- | ------------- | -------------
[**askResetPassword**](AuthApi.md#askresetpassword) | **POST** /api/v1/auth/askResetPassword | 
[**login**](AuthApi.md#login) | **POST** /api/v1/auth/login | 
[**refreshToken**](AuthApi.md#refreshtoken) | **POST** /api/v1/auth/token/refresh | 
[**register**](AuthApi.md#register) | **POST** /api/v1/auth/register | 
[**resetPassword**](AuthApi.md#resetpassword) | **POST** /api/v1/auth/resetPassword | 


# **askResetPassword**
> askResetPassword(askResetPassword)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getAuthApi();
final AskResetPassword askResetPassword = ; // AskResetPassword | 

try { 
    api.askResetPassword(askResetPassword);
} catch on DioError (e) {
    print('Exception when calling AuthApi->askResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **askResetPassword** | [**AskResetPassword**](AskResetPassword.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> LoginResponse login(loginRequest)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getAuthApi();
final LoginRequest loginRequest = ; // LoginRequest | 

try { 
    final response = api.login(loginRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> LoginResponse refreshToken(refreshTokenRequest)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getAuthApi();
final RefreshTokenRequest refreshTokenRequest = ; // RefreshTokenRequest | 

try { 
    final response = api.refreshToken(refreshTokenRequest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->refreshToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenRequest** | [**RefreshTokenRequest**](RefreshTokenRequest.md)|  | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> LoginResponse register(user)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getAuthApi();
final User user = ; // User | 

try { 
    final response = api.register(user);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->register: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)|  | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> resetPassword(resetPassword)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getAuthApi();
final ResetPassword resetPassword = ; // ResetPassword | 

try { 
    api.resetPassword(resetPassword);
} catch on DioError (e) {
    print('Exception when calling AuthApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPassword** | [**ResetPassword**](ResetPassword.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

