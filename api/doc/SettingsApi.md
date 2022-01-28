# heal_happy_sdk.api.SettingsApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://soignez-heureux.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSettings**](SettingsApi.md#getsettings) | **GET** /api/v1/settings | 
[**updateSettings**](SettingsApi.md#updatesettings) | **PATCH** /api/v1/admin/settings | 


# **getSettings**
> AppSettings getSettings()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getSettingsApi();

try { 
    final response = api.getSettings();
    print(response);
} catch on DioError (e) {
    print('Exception when calling SettingsApi->getSettings: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AppSettings**](AppSettings.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSettings**
> updateSettings(appSettings)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getSettingsApi();
final AppSettings appSettings = ; // AppSettings | 

try { 
    api.updateSettings(appSettings);
} catch on DioError (e) {
    print('Exception when calling SettingsApi->updateSettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appSettings** | [**AppSettings**](AppSettings.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

