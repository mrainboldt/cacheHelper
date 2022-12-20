/**
 * @description methods to help utilize the cache
 * @author      M Rainboldt
 * @created     JUL 2020
 */
public class CacheHelper {
    /**
     * @description         checks if setting is in org cache if not adds and returns the setting
     * @param  settingName  developer name of setting to be returned
     * @param  objectName   api name of object setting is from in case it needs to be querired
     * @return              the setting requested
     */
    public static Object getFromOrgCache(String settingName, String objectName)
    {
        Object setting;
        String cachedName = getCachedName(settingName);
        //check if key setting is in cache
        if(!Cache.Org.contains(cachedName))
        {
            setting = addOrgCache(settingName, objectName);
        }
        else
        {
            setting = Cache.Org.get(cachedName);
            System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' retrieved from cache.');
        }

        return setting;
    }

    /**
     * @description         queries for setting and adds to org cache
     * @param  settingName  developer name of setting to be queried
     * @param  objectName   api name of object to be queried
     * @return              setting after it has been added to cache
     */
    public static Object addOrgCache(String settingName, String objectName)
    {
        System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' has not yet been cached.');
        Object setting = getSetting(settingName, objectName);
        //adds setting to cache if setting is found
        if(setting != null)
        {
            Cache.Org.put(getCachedName(settingName), setting);
            System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' has now been cached.');
        }
        return setting;
    }

    /**
     * @description         checks if setting is in session cache if not adds and returns the setting
     * @param  settingName  developer name of setting to be returned
     * @param  objectName   api name of object setting is from in case it needs to be querired
     * @return              the setting requested
     */
    public static Object getFromSessionCache(String settingName, String objectName)
    {
        Object setting;
        String cachedName = getCachedName(settingName);
        //check if key setting is in cache
        if(!Cache.Session.contains(cachedName))
        {
            setting = addOrgCache(settingName, objectName);
        }
        else
        {
            setting = Cache.Session.get(cachedName);
            System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' retrieved from cache.');
        }

        return setting;
    }

    /**
     * @description         queries for setting and adds to session cache
     * @param  settingName  developer name of setting to be queried
     * @param  objectName   api name of object to be queried
     * @return              setting after it has been added to cache
     */
    public static Object addSessionCache(String settingName, String objectName)
    {
        System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' has not yet been cached.');
        Object setting = getSetting(settingName, objectName);

        //adds setting to cache if setting is found
        if(setting != null)
        {
            Cache.Session.put(getCachedName(settingName), setting);
            System.debug(LoggingLevel.INFO, 'Setting ' + settingName + ' has now been cached.');
        }
        return setting;
    }

    /**
     * @description         get the name of the setting in the cache
     * @param  settingName  developer name of the setting record
     * @return              setting developer name converted to its name in the cache
     */
    public static String getCachedName(String settingName)
    {
        return settingName.replaceAll('_', '');
    }

    /**
     * @description         query the setting and all of its fields
     * @param  settingName developer name of the setting
     * @param  objectName  api name of the setting object
     * @return             instance of the setting
     */
    private static Object getSetting(String settingName, String objectName)
    {
        return Database.query(SObjectHelper.generateQueryStringByObjectName(objectName, false)
                                + ' WHERE DeveloperName = :settingName'
                                + ' LIMIT 1');
    }
}