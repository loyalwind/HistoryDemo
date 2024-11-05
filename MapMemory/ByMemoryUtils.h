//
//  ByMemoryUtils.h
//  动态内存工具，用于保存一些运行中的数据，Lua 和 原生共享
//
//  Created by loyalwind on 2019/12/12.
//  Copyright © 2019 pengweijian. All rights reserved.
//

#ifndef ByMemoryUtils_h
#define ByMemoryUtils_h

#include <stdio.h>
#include <map>
#include <string>

namespace by {
class MemoryUtils {
    public:
        static MemoryUtils *getInstance();
        
        void setStringForKey(const char* key, const std::string &value);
        void clearStringForKey(const char* key);
        void clearAll();

        std::string getStringForKey(const char* key) {return getStringForKey(key,"");};
        std::string getStringForKey(const char* key, const std::string &defaultValue);
    private:
        MemoryUtils();
        ~MemoryUtils();
        std::map<const char*, std::string> m_stringMap;
    };
};
#endif /* ByMemoryUtils_h */
