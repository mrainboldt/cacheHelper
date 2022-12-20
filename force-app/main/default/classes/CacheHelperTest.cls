/**
 * @description test coverage for CacheHelper
 * @author      M Rainboldt
 * @created     JUL 2020
 */
@isTest(isParallel=true)
private class CacheHelperTest {

    /**
     * @description test functionality around adding and getting from org cache
     */
    @isTest static void testOrgCache()
    {
        //ARRANGE
        Key_Setting__mdt setting = [SELECT DeveloperName FROM Key_Setting__mdt LIMIT 1];


        //ACT
        Test.startTest();
        Key_Setting__mdt result = ((List<Key_Setting__mdt>)CacheHelper.getFromOrgCache(setting.DeveloperName, 'Key_Setting__mdt'))[0];
        Test.stopTest();

        //ASSERT
        System.assertNotEquals(null, result);
        System.assertEquals(setting.DeveloperName, result.DeveloperName);
    }

    /**
     * @description test functionality around adding and getting from session cache
     */
    @isTest static void testSessionCache()
    {
        //ARRANGE
        Key_Setting__mdt setting = [SELECT DeveloperName FROM Key_Setting__mdt LIMIT 1];

        //ACT
        Test.startTest();
        Key_Setting__mdt result = ((List<Key_Setting__mdt>)CacheHelper.getFromSessionCache(setting.DeveloperName, 'Key_Setting__mdt'))[0];
        Test.stopTest();

        //ASSERT
        System.assertNotEquals(null, result);
        System.assertEquals(setting.DeveloperName, result.DeveloperName);
    }
}