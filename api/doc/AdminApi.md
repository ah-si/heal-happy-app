# heal_happy_sdk.api.AdminApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://localhost:3443*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](AdminApi.md#createuser) | **POST** /api/v1/admin/users | 
[**deleteUser**](AdminApi.md#deleteuser) | **DELETE** /api/v1/admin/users/{id} | 
[**getDashboard**](AdminApi.md#getdashboard) | **GET** /api/v1/admin/dashboard | 
[**getHealerStats**](AdminApi.md#gethealerstats) | **GET** /api/v1/admin/healers/stats | 
[**getPendingHealer**](AdminApi.md#getpendinghealer) | **GET** /api/v1/admin/users/pending | 
[**searchUsers**](AdminApi.md#searchusers) | **GET** /api/v1/admin/users | 
[**updateUser**](AdminApi.md#updateuser) | **PUT** /api/v1/admin/users/{id} | 
[**verifyUser**](AdminApi.md#verifyuser) | **POST** /api/v1/admin/users/{id}/verify | 


# **createUser**
> User createUser(user)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final User user = ; // User | 

try { 
    final response = api.createUser(user);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUser**
> deleteUser(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final String id = id_example; // String | 

try { 
    api.deleteUser(id);
} catch on DioError (e) {
    print('Exception when calling AdminApi->deleteUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDashboard**
> Dashboard getDashboard()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();

try { 
    final response = api.getDashboard();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getDashboard: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Dashboard**](Dashboard.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealerStats**
> BuiltList<HealerStats> getHealerStats(start, end)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final Date start = ; // Date | 
final Date end = ; // Date | 

try { 
    final response = api.getHealerStats(start, end);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getHealerStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start** | [**Date**](.md)|  | 
 **end** | [**Date**](.md)|  | 

### Return type

[**BuiltList&lt;HealerStats&gt;**](HealerStats.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingHealer**
> PaginatedUsers getPendingHealer(page)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final int page = 56; // int | 

try { 
    final response = api.getPendingHealer(page);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->getPendingHealer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 

### Return type

[**PaginatedUsers**](PaginatedUsers.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchUsers**
> PaginatedUsers searchUsers(page, query, type, job, isActivated)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final int page = 56; // int | 
final String query = query_example; // String | 
final UserTypeEnum type = ; // UserTypeEnum | 
final String job = job_example; // String | 
final bool isActivated = true; // bool | 

try { 
    final response = api.searchUsers(page, query, type, job, isActivated);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->searchUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **query** | **String**|  | [optional] 
 **type** | [**UserTypeEnum**](.md)|  | [optional] 
 **job** | **String**|  | [optional] 
 **isActivated** | **bool**|  | [optional] 

### Return type

[**PaginatedUsers**](PaginatedUsers.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> User updateUser(id, user)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final String id = id_example; // String | 
final User user = ; // User | 

try { 
    final response = api.updateUser(id, user);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **user** | [**User**](User.md)|  | 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyUser**
> User verifyUser(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getAdminApi();
final String id = id_example; // String | 

try { 
    final response = api.verifyUser(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AdminApi->verifyUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)
