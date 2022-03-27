# heal_happy_sdk.api.DonationsApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://soignez-heureux.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getProducts**](DonationsApi.md#getproducts) | **GET** /api/v1/donations/products | 
[**getSessionInfo**](DonationsApi.md#getsessioninfo) | **GET** /api/v1/donations/donate | 


# **getProducts**
> BuiltList<Product> getProducts()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getDonationsApi();

try { 
    final response = api.getProducts();
    print(response);
} catch on DioError (e) {
    print('Exception when calling DonationsApi->getProducts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Product&gt;**](Product.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSessionInfo**
> SessionInfo getSessionInfo(id, mode, email)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getDonationsApi();
final String id = id_example; // String | 
final String mode = mode_example; // String | 
final String email = email_example; // String | 

try { 
    final response = api.getSessionInfo(id, mode, email);
    print(response);
} catch on DioError (e) {
    print('Exception when calling DonationsApi->getSessionInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **mode** | **String**|  | 
 **email** | **String**|  | [optional] 

### Return type

[**SessionInfo**](SessionInfo.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

