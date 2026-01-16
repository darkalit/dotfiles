pragma Singleton

import Quickshell

Singleton {
    id: root

    function iconExists(iconName) {
        if (!iconName || iconName.length == 0)
            return false;
        return (Quickshell.iconPath(iconName, true).length > 0) && !iconName.includes("image-missing");
    }

    function getReverseDomainNameAppName(str) {
        return str.split('.').slice(-1)[0];
    }

    function getKebabNormalizedAppName(str) {
        return str.toLowerCase().replace(/\s+/g, "-");
    }

    function getUndescoreToKebabAppName(str) {
        return str.toLowerCase().replace(/_/g, "-");
    }

    function guessIcon(str) {
        if (!str || str.length == 0)
            return "image-missing";

        const entry = DesktopEntries.byId(str);
        if (entry)
            return entry.icon;

        if (iconExists(str))
            return str;

        const lowercased = str.toLowerCase();
        if (iconExists(lowercased))
            return lowercased;

        const reverseDomainNameAppName = getReverseDomainNameAppName(str);
        if (iconExists(reverseDomainNameAppName))
            return reverseDomainNameAppName;

        const lowercasedDomainNameAppName = reverseDomainNameAppName.toLowerCase();
        if (iconExists(lowercasedDomainNameAppName))
            return lowercasedDomainNameAppName;

        const kebabNormalizedGuess = getKebabNormalizedAppName(str);
        if (iconExists(kebabNormalizedGuess))
            return kebabNormalizedGuess;

        const undescoreToKebabGuess = getUndescoreToKebabAppName(str);
        if (iconExists(undescoreToKebabGuess))
            return undescoreToKebabGuess;

        const heuristicEntry = DesktopEntries.heuristicLookup(str);
        if (heuristicEntry)
            return heuristicEntry.icon;

        return "application-x-executable";
    }
}
