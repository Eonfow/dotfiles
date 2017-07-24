Function WowFunction {
    git status
}
Function EditaliasFunction {
    code $PROFILE
}
Function TagGitFunction {
    Param(
        [Parameter(Mandatory=$true, Position=0)][String]$TAG_TO_USE,
        [Parameter(Mandatory=$true, Position=1)][string]$MESSAGE
    )
    Write-Output 'git pull'
    git pull
    Write-Output 'git push'
    git push
    Write-Output "git tag -a $TAG_TO_USE -m `"$MESSAGE`""
    git tag -a $TAG_TO_USE -m "$($MESSAGE)"
    Write-Output "git push origin $TAG_TO_USE"
    git push origin $TAG_TO_USE
}
Function UnTagGitFunction {
    Param(
        [Parameter(Mandatory=$true, Position=0)][String]$TAG_TO_USE
    )
    Write-Output 'git pull'
    git pull
    Write-Output 'git push'
    git push
    git tag -d $TAG_TO_USE
    git push origin :refs/tags/$TAG_TO_USE
}
Function ReTagGitFunction {
    Param(
        [Parameter(Mandatory=$true, Position=0)][String]$TAG_TO_USE
    )
    Write-Output 'git pull'
    git pull
    Write-Output 'git push'
    git push
    git tag -f $TAG_TO_USE
    git push -f origin $TAG_TO_USE
}
Function GetLastTagGitFunction {
    Param(
        [Parameter(Mandatory=$true, Position=0)][String]$TAG_TO_USE,
        [Parameter(Mandatory=$false, Position=1)][Int]$NUMBER_OF_TAGS=1
    )
    git for-each-ref --sort=taggerdate --format '%(tag)' refs/tags | grep $TAG_TO_USE | Select-Object -Last $NUMBER_OF_TAGS
}
Function GrepFunction {
    $input | Out-string -Stream | Select-String $args
}
Function Get-PresentBranch {
    $HEAD = Get-Content .\.git\HEAD
    $SPLIT = $HEAD -split ('refs/heads/')
    $BRANCH = $SPLIT[1]
    $BRANCH
}
$PATH_TO_DAILY_PROJECTS = "$PROFILE/../dailyProjects.txt"
Function Set-DailyProjects {
    Param(
        [Parameter(Mandatory=$true, Position=0)][Array]$PROJETS_TO_SET
    )
    if (!(Test-Path -Path $PATH_TO_DAILY_PROJECTS)) {
        New-Item -Type File -Path $PATH_TO_DAILY_PROJECTS -Force
    }
    Clear-Content $PATH_TO_DAILY_PROJECTS
    foreach ($PROJET in $PROJETS_TO_SET) {
        Add-DailyProject $PROJET
    }
}
Function Add-DailyProject {
    Param(
        [Parameter(Mandatory = $true, Position = 0)][String]$PROJET_TO_ADD
    )
    Add-Content $PATH_TO_DAILY_PROJECTS "$PROJET_TO_ADD"
}
Function Update-DailyProjects {
    $CURRENT_FOLDER = Get-Location
    $FILE_CONTENT = Get-Content $PATH_TO_DAILY_PROJECTS
    foreach ($LINE in $FILE_CONTENT) {
        Try {
            Invoke-Expression $LINE
        } Catch {
            Set-Location $LINE
        }
        Get-Location
        $PRESENT_BRANCH = GetPresentBranch
        git checkout "master"
        git pull
        git checkout $PRESENT_BRANCH
        git merge "master"
    }
    Set-Location $CURRENT_FOLDER
}

set-item -path alias:wow -value WowFunction
set-item -path alias:editalias -value EditaliasFunction

set-item -path alias:tag -value TagGitFunction
set-item -path alias:untag -value UnTagGitFunction
set-item -path alias:retag -value ReTagGitFunction
set-item -path alias:getLastTag -value GetLastTagGitFunction

set-item -path alias:grep -value GrepFunction
