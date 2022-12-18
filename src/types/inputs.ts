import * as core from '@actions/core'

export const BDS_PATH = core.getInput('BDS_PATH', {required: true})
export const TIMEOUT_TICKS = Number(
  core.getInput('TIMEOUT_TICKS', {
    required: true
  })
)
export const PACKS = core.getMultilineInput('PACKS')
export const TEST_TAGS = core.getMultilineInput('TEST_TAGS')
